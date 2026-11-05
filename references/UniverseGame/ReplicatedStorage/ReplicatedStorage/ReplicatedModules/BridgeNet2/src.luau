  

 

local RunService = game:GetService("RunService");
local Client = require(script.Client);
require(script.PublicTypes);
local Server = require(script.Server);
local MockBridge = require(script.Studio.MockBridge);
local NetworkUtils = require(script.Utilities.NetworkUtils);
local Output = require(script.Utilities.Output);
local isEditMode = require(script.Utilities.isEditMode);
local version = require(script.version);
local u1 = RunService:IsServer();
task.spawn(function() -- Line: 15
    -- upvalues: isEditMode (copy), u1 (copy), Server (copy), Client (copy)
    if not isEditMode then
        if u1 then
            Server.start();

            return;
        end;

        Client.start();
    end;
end);
local v2 = {
    ToHex = NetworkUtils.ToHex,
    ToReadableHex = NetworkUtils.ToReadableHex,
    FromHex = NetworkUtils.FromHex,
    CreateUUID = NetworkUtils.CreateUUID
};
local v3;

if u1 then
    v3 = Server.makeIdentifier;
else
    v3 = Client.makeIdentifier;
end;

v2.ReferenceIdentifier = v3;
local v4;

if u1 then
    v4 = Server.deser;
else
    v4 = Client.deser;
end;

v2.Deserialize = v4;
local v5;

if u1 then
    v5 = Server.ser;
else
    v5 = Client.ser;
end;

v2.Serialize = v5;
v2.AllPlayers = Server.playerContainers().All;
v2.PlayersExcept = Server.playerContainers().Except;
v2.Players = Server.playerContainers().Players;
local v6;

if u1 then
    v6 = Server.makeBridge;
else
    v6 = Client.makeBridge;
end;

v2.ReferenceBridge = v6;
local v7;

if u1 then
    v7 = Server.makeBridge;
else
    v7 = nil;
end;

v2.ServerBridge = v7;
local v8;

if u1 then
    v8 = nil;
else
    v8 = Client.makeBridge;
end;

v2.ClientBridge = v8;
v2.Types = script.ExportedTypes;

function v2.HandleInvalidPlayer(p9) -- Line: 117
    -- upvalues: Output (copy), u1 (copy), Server (copy)
    Output.fatalAssert(u1, "Cannot call from client");
    Server.invalidPlayerhandler(p9);
end;

v2.version = version;

if isEditMode then
    Output.log("running BridgeNet2 in mock mode");
    v2.ClientBridge = MockBridge;
    v2.ServerBridge = nil;
    v2.ReferenceBridge = MockBridge;

    function v2.ReferenceIdentifier(p10) -- Line: 133
        return p10;
    end;

    function v2.Serialize(p11) -- Line: 137
        return p11;
    end;

    function v2.Deserialize(p12) -- Line: 141
        return p12;
    end;
end;

table.freeze(v2);

return v2;