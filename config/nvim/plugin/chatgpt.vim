python3 << EOF
import sys
sys.path.append('/home/oskari/p/ai_projects/chatgpt.py')
EOF

function! ChatGPTGenerateCode()
    lua << EOF
local buf = vim.api.nvim_create_buf(false, true)

-- Luo popup-ikkuna
vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = 60,
    height = 5,
    row = math.floor((vim.api.nvim_get_option("lines") - 5) / 2),
    col = math.floor((vim.api.nvim_get_option("columns") - 60) / 2),
    style = 'minimal',
    border = 'rounded',
})

-- Aseta sisältö ja sulkemismekanismi
vim.api.nvim_buf_set_lines(buf, 0, -1, false, {""})
vim.api.nvim_buf_set_option(buf, 'modifiable', true)
vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', ':lua SubmitPrompt()<CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(buf, 'i', '<CR>', '<Esc>:lua SubmitPrompt()<CR>', { noremap = true, silent = true })

-- Sulje popup ESC:llä
vim.api.nvim_buf_set_keymap(buf, 'n', '<Esc>', ':q<CR>', { noremap = true, silent = true })

vim.api.nvim_command("startinsert")

function SubmitPrompt()
    -- Hae käyttäjän syöte popupista
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local prompt = table.concat(lines, "\n")

    -- Hae tiedoston sisältö kontekstiksi
    local file_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")

    -- Sulje popup-ikkuna
    vim.api.nvim_win_close(0, true)

    -- Lähetä kysymys ChatGPT:lle (Python-kutsun kautta)
    vim.cmd("python3 << EOF\n" ..
        "import vim\n" ..
        "from chatgpt import generate_code_with_context\n" ..
        string.format("result = generate_code_with_context('''%s''', '''%s''')\n", prompt, file_content) ..
        "vim.vars['chatgpt_result'] = result\n" ..
        "EOF")
    -- Hae vastaus ja lisää koodipätkä kursorin kohtaan
    local generated_code = vim.g.chatgpt_result
    if generated_code then
        vim.api.nvim_put(vim.split(generated_code, "\n"), 'c', true, true)
    else
        print("ChatGPT ei antanut vastausta.")
    end
end
EOF

endfunction

function! ChatGPTExplain()
    python3 << EOF
import re
import vim
from chatgpt import explain_selected_text

# Hae valittu teksti Vimistä (esim. nykyinen rivi)
selected_text = str(vim.eval("getline(\"'<\", \"'>\")"))

# Kutsu Python-funktiota
response = explain_selected_text(selected_text)
# print(response)
vim.vars['chatgpt_response'] = response
vim.command(f"call ShowPopup()")
EOF
setlocal wrap
endfunction

function! ShowPopup()
    lua << EOF
local response = vim.g.chatgpt_response

-- Jaa vastaus riveihin
local lines = vim.split(response, '\n')

-- Laske popupin koko
local max_width = vim.api.nvim_get_option("columns") - 2  -- Jätetään 2 saraketta marginaaliksi
local max_height = vim.api.nvim_get_option("lines") - 2   -- Jätetään 2 riviä marginaaliksi

-- Määritä popupin dynaaminen leveys ja korkeus
local popup_width = math.min(max_width, math.max(20, #response:match("[^\n]+") or 0) + 4) -- Rivin pisin teksti + marginaali
local popup_height = math.min(max_height, #lines * 2)

local buf = vim.api.nvim_create_buf(false, true)

-- Aseta popup-ikkuna
vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = popup_width,
    height = popup_height,
    row = math.floor((max_height - popup_height) / 2), -- Keskitetään
    col = math.floor((max_width - popup_width) / 2),   -- Keskitetään
    style = 'minimal',
    border = 'rounded',
})

-- Lisää sisältö popupiin
vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

-- Lisää sulkemispainike
vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
EOF
setlocal wrap
endfunction
