-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = { 'org' },
  },
  ensure_installed = { 'org' },   -- Or run :TSUpdate org
}

require('leap') -- .add_default_mappings()
require('leap').opts.case_sensitive = true
local leap_maps = {
  { { "x", "o" }, "z", "<Plug>(leap-forward-to)",   "Leap forward to" },
  { { "x", "o" }, "Z", "<Plug>(leap-backward-to)",  "Leap backward to" },
  { { "n", "x", "o" }, "s", "<Plug>(leap-forward-to)",   "Leap forward to" },
  { { "n", "x", "o" }, "S", "<Plug>(leap-backward-to)",  "Leap backward to" },
  { { "x", "o" },    "x",  "<Plug>(leap-forward-till)",  "Leap forward till" },
  { { "x", "o" },    "X",  "<Plug>(leap-backward-till)", "Leap backward till" },
  { { "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", "Leap from window" },
  { { "n", "x", "o" }, "gs", "<Plug>(leap-cross-window)", "Leap from window" },
  { { "n", "x", "o" }, "gz", "<Plug>(leap-from-window)", "Leap from window" },
  { { "n", "x", "o" }, "gz", "<Plug>(leap-cross-window)", "Leap from window" }
}
for _, map in ipairs(leap_maps) do
  vim.keymap.set(map[1], map[2], map[3], { silent = true, desc = map[4] })
end

require('leap').add_repeat_mappings(';', ',', {
  -- False by default. If set to true, the keys will work like the
  -- native semicolon/comma, i.e., forward/backward is understood in
  -- relation to the last motion.
  relative_directions = true,
  -- By default, all modes are included.
  modes = {'n', 'x', 'o'},
})

require('leap-spooky').setup {
  -- Mappings will be generated corresponding to all native text objects,
  -- like: (ir|ar|iR|aR|im|am|iM|aM){obj}.
  -- Special line objects will also be added, by repeating the affixes.
  -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
  -- window.
  affixes = {
    -- The cursor moves to the targeted object, and stays there.
    magnetic = { window = 'm', cross_window = 'M' },
    -- The operation is executed seemingly remotely (the cursor boomerangs
    -- back afterwards).
    remote = { window = 'r', cross_window = 'R' },
  },
  -- Defines text objects like `riw`, `raw`, etc., instead of
  -- targets.vim-style `irw`, `arw`.
  prefix = false,
  -- The yanked text will automatically be pasted at the cursor position
  -- if the unnamed register is in use.
  paste_on_remote_yank = false,
}

require('orgmode').setup({
  org_agenda_files = { '~/org/*' },
  org_default_notes_file = '~/org/inbox.org',
})

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                       -- false will only do exact matching
      override_generic_sorter = true,     -- override the generic sorter
      override_file_sorter = true,        -- override the file sorter
      case_mode = "smart_case",           -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    coc = {
      theme = 'ivy',
      prefer_locations = true,     -- always use Telescope locations to preview definitions/declarations/implementations etc
    }
  }
}

-- GH pull request
require "octo".setup()

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
