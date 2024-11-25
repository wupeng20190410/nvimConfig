return {
  "sphamba/smear-cursor.nvim",

  opts = {
    -- Cursor color. Defaults to Cursor gui color
    cursor_color = "#d3cdc3",

    -- Background color. Defaults to Normal gui background color
    normal_bg = "#282828",

    -- Smear cursor when switching buffers
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines
    smear_between_neighbor_lines = true,

    -- Use floating windows to display smears over wrapped lines or outside buffers.
    -- May have performance issues with other plugins.
    use_floating_windows = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,
                                   -- Defaults Range
    stiffness = 0.6,               -- 0.6      [0, 1]
    trailing_stiffness = 0.6,      -- 0.3      [0, 1]
    trailing_exponent = 0,         -- 0.1      >= 0
    distance_stop_animating = 0.5, -- 0.1      > 0
    hide_target_hack = false,      -- true     boolean
  },


}

--return {
--    "karb94/neoscroll.nvim",
--    config = function()
--        require('neoscroll').setup({
--
--            mappings = { -- Keys to be mapped to their corresponding default scrolling animation
--                '<C-u>', '<C-d>',
--                '<C-b>', '<C-f>',
--                '<C-y>', '<C-e>',
--                'zt', 'zz', 'zb',
--            },
--            hide_cursor = true, -- Hide cursor while scrolling
--            stop_eof = true,   -- Stop at <EOF> when scrolling downwards
--            respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
--            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
--            easing = 'linear', -- Default easing function
--            pre_hook = nil,    -- Function to run before the scrolling animation starts
--            post_hook = nil,   -- Function to run after the scrolling animation ends
--            performance_mode = false, -- Disable "Performance Mode" on all buffers.
--            ignored_events = { -- Events ignored while scrolling
--                'WinScrolled', 'CursorMoved'
--            },
--        })
--    end
--}
