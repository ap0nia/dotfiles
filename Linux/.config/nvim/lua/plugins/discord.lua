return {
  'andweeb/presence.nvim',

  opts = {
    --------------------------------------------------------------------------------------
    -- General options
    --------------------------------------------------------------------------------------

    -- Update activity based on autocmd events.
    -- If `false`, map or manually execute `:lua package.loaded.presence:update()`
    auto_update         = true,

    -- Text displayed when hovered over the Neovim logo.
    neovim_image_text   = "hyperextensible Vim-based text editor",

    -- Main image display (either "neovim" or "file").
    main_image          = "neovim",

    -- Use custom Discord application client id (not recommended).
    client_id           = "793271441293967371",

    -- Log messages at or above this level 
    -- One of: "debug", "info", "warn", "error".
    log_level           = "info",

    -- Number of seconds to debounce events,
    -- i.e. calls to `:lua package.loaded.presence:update(<filename>, true)`.
    debounce_timeout    = 10,

    -- Whether to displays the current line number instead of the current project.
    enable_line_number  = false,

    -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches.
    blacklist           = {},

    -- Configure Rich Presence button(s), one of: 
    -- - boolean to enable/disable
    -- - static table (`{{ label = "<label>", url = "<url>" }, ...}`
    -- - function(buffer: string, repo_url: string|nil): table)
    buttons             = true,

    -- Custom file asset definitions keyed by file names and extensions.
    -- See default config at `lua/presence/file_assets.lua` for reference.
    file_assets         = {},

    -- Whether to show the timer.
    show_time           = true,

    --------------------------------------------------------------------------------------
    -- Rich Presence text options
    --------------------------------------------------------------------------------------

    -- Format string rendered when an editable file is loaded in the buffer.
    -- String or function(filename: string): string.
    editing_text        = "Editing %s",

    -- Format string rendered when browsing a file explorer.
    -- string or function(file_explorer_name: string): string.
    file_explorer_text  = "Browsing %s",

    -- Format string rendered when committing changes in git.
    -- String or function(filename: string): string.
    git_commit_text     = "Committing changes",

    -- Format string rendered when managing plugins.
    -- String or function(plugin_manager_name: string): string.
    plugin_manager_text = "Managing plugins",

    -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer.
    -- String or function(filename: string): string.
    reading_text        = "Reading %s",

    -- Format string rendered when in a git repository.
    -- String or function(project_name: string|nil, filename: string): string.
    workspace_text      = "Working on %s",

    -- Format string rendered when `enable_line_number` is set to true.
    -- String or function(line_number: number, line_count: number): string.
    line_number_text    = "Line %s out of %s",
  }
}
