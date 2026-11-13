local function get_root()
	local cwd = vim.fn.getcwd()
	-- Check for git root or flake.nix
	local git_root = vim.fs.root(cwd, ".git")
	local nix_root = vim.fs.root(cwd, "flake.nix")
	local devenv_root = vim.fs.root(cwd, "devenv.nix")
	return git_root or nix_root or devenv_root
end

NP = NP or {}
NP.dirs = {}
NP.dirs.root = get_root()

if NP.dirs.root then
	NP.dirs.nvim = NP.dirs.root .. "/.nvim"
	NP.dirs.org = NP.dirs.root .. "/orgfiles"
	local dirs = { "sessions", "scratchs" }

	for _, dir in ipairs(dirs) do
		local dir_path = string.format("%s/%s", NP.dirs.nvim, dir)
		vim.system({
			"mkdir",
			"-p",
			dir_path,
		})

		NP.dirs[dir] = dir_path
	end

	-- Yarn Berry PnP work-arounds
	local sdk = NP.dirs.root .. "/.yarn/sdks"

	if vim.fn.isdirectory(sdk) == 1 then
		NP.yarn_pnp = sdk
	end
end
