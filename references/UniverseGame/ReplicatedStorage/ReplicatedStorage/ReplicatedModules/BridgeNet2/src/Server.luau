  

 

require(script.Parent.Types);
local isEditMode = require(script.Parent.Utilities.isEditMode);
local PlayerContainers = require(script.PlayerContainers);
local ServerBridge = require(script.ServerBridge);
local ServerIdentifiers = require(script.ServerIdentifiers);
local ServerProcess = require(script.ServerProcess);
local u1 = {};

return {
    start = function() -- Line: 13, Name: start
        -- upvalues: isEditMode (copy), ServerIdentifiers (copy), ServerProcess (copy)
        if isEditMode then
            return;
        end;

        ServerIdentifiers.start();
        ServerProcess.start();
    end,

    makeBridge = function(p2) -- Line: 22, Name: makeBridge
        -- upvalues: u1 (copy), ServerBridge (copy)
        if u1[p2] then
            return u1[p2];
        end;

        local v3 = ServerBridge(p2);
        u1[p2] = v3;

        return v3;
    end,

    ser = function(p4) -- Line: 34, Name: ser
        -- upvalues: ServerIdentifiers (copy)
        return ServerIdentifiers.ser(p4);
    end,

    deser = function(p5) -- Line: 38, Name: deser
        -- upvalues: ServerIdentifiers (copy)
        return ServerIdentifiers.deser(p5);
    end,

    makeIdentifier = function(p6) -- Line: 42, Name: makeIdentifier
        -- upvalues: ServerIdentifiers (copy)
        return ServerIdentifiers.ref(p6);
    end,

    playerContainers = function() -- Line: 46, Name: playerContainers
        -- upvalues: PlayerContainers (copy)
        return PlayerContainers;
    end,

    invalidPlayerhandler = function(p7) -- Line: 50, Name: invalidPlayerhandler
        -- upvalues: ServerProcess (copy)
        ServerProcess.setInvalidPlayerFunction(p7);
    end
};