local fs = require("yalms.fs")
local FsWatch = require("yalms.fs_watch")

---@class ThemeWatchOpts
---@field config string? Config file path (default: ~/.config/tw/tw.json)

---@class ThemeWatch
---@field _watch? FsWatch
---@field _path string
---@field _file string
local ThemeWatch = {}
ThemeWatch.__index = ThemeWatch

---@param opts? ThemeWatchOpts
function ThemeWatch:new(opts)
  ---@type ThemeWatch
  local instance = setmetatable({}, self)
  instance._file = (opts and opts.config and vim.fn.expand(opts.config)) or vim.fn.expand("~/.config/tw/tw.json")
  instance._path = vim.fn.fnamemodify(instance._file, ':h')
  instance:_reload()
  instance:watch()
  return instance
end

function ThemeWatch:watch()
  if not self._watch then
    self._watch = FsWatch:new({
      root = self._path,
      recursive = true,
      on_change = function(_)
        self:_reload()
      end,
    })

    self._watch:start()
  end
end

function ThemeWatch:_reload()
  ---@type { theme: 'light' | 'dark', colorscheme?: string }
  local content = fs.safe_read_json(self._file, {})

  if content.theme then
    local theme = content.theme
    vim.cmd("set background=" .. theme)

    if content.colorscheme then
      vim.cmd("colorscheme " .. (content.colorscheme))
    end
    vim.cmd("redraw")
  end
end

function ThemeWatch:destory()
  self._watch:stop()
  self._watch = nil
end

return ThemeWatch
