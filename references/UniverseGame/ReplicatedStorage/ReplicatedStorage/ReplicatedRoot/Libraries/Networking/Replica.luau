  

 

require(script.ReplicaShared.Maid);

if game:GetService("RunService"):IsClient() then
    return require(script.ReplicaClient);
end;

return require(script.ReplicaServer);