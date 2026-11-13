local ThemeWatch = require("tw.watch")
---@class ThemeWatcher
local ThemeWatcher = {} ---@type ThemeWatcher

---@class Global
---@field __theme_watch ThemeWatcher
_G = _G or {}

function ThemeWatcher.setup()
	if not _G.__theme_watch then
		_G.__theme_watch = ThemeWatch:new()
	end
end

function ThemeWatcher.teardown()
	if _G.__theme_watch then
		_G.__theme_watch:destory()
		_G.__theme_watch = nil
	end
end

return ThemeWatcher
