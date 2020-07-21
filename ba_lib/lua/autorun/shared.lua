local basefol = "ba_lib/" -- folder name in lua

local function LoadModuleFolder(modulenm)
	local full_folder = basefol
	if modulenm and modulenm ~= "" then
		full_folder = full_folder .. modulenm
	end

	local files, folders = file.Find(full_folder .. "*", "LUA")

	-- Recursive file search
	for _, ifolder in ipairs(folders) do
		if ifolder == 'example' then continue end
		LoadModuleFolder(modulenm .. ifolder .. "/")
	end

	for _, shfile in ipairs(file.Find(full_folder .. "sh_*.lua", "LUA")) do
		if SERVER then AddCSLuaFile(full_folder .. shfile) end
		include(full_folder .. shfile)
		print('sh',full_folder .. shfile)
	end

	if SERVER then
		for _, svfile in ipairs(file.Find(full_folder .. "sv_*.lua", "LUA")) do
			include(full_folder .. svfile)
			print('sv',full_folder .. svfile)
		end
	end

	for _, clfile in ipairs(file.Find(full_folder .. "cl_*.lua", "LUA")) do
		if SERVER then AddCSLuaFile(full_folder .. clfile) end
		if CLIENT then include(full_folder .. clfile) end
		print('cl',full_folder .. clfile)
	end
end
BA = {}
LoadModuleFolder("")


