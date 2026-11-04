  

local table_clone_ret = table.clone(require(script.Parent.Default));
table_clone_ret.LobbyNPCs.NormalServers = false;

return table_clone_ret;