  

local table_clone_ret = table.clone(require(script.Parent.Default));
table_clone_ret.LobbyNPCs.ProServers = false;
table_clone_ret.LevelReq = 30;

return table_clone_ret;