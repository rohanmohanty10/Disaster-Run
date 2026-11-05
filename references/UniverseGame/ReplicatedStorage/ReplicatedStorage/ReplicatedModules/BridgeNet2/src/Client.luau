  

 

local ClientBridge = require(script.ClientBridge);
local ClientIdentifiers = require(script.ClientIdentifiers);
local ClientProcess = require(script.ClientProcess);
require(script.Parent.Types);
local isEditMode = require(script.Parent.Utilities.isEditMode);
local u1 = {};

return {
    start = function() -- Line: 12, Name: start
        -- upvalues: isEditMode (copy), ClientProcess (copy), ClientIdentifiers (copy)
        if isEditMode then
            return;
        end;

        ClientProcess.start();
        ClientIdentifiers.start();
    end,

    ser = function(p2) -- Line: 21, Name: ser
        -- upvalues: isEditMode (copy), ClientIdentifiers (copy)
        if isEditMode then
            return p2;
        end;

        return ClientIdentifiers.ser(p2);
    end,

    deser = function(p3) -- Line: 29, Name: deser
        -- upvalues: isEditMode (copy), ClientIdentifiers (copy)
        if isEditMode then
            return p3;
        end;

        return ClientIdentifiers.deser(p3);
    end,

    makeIdentifier = function(p4, p5) -- Line: 37, Name: makeIdentifier
        -- upvalues: isEditMode (copy), ClientIdentifiers (copy)
        if isEditMode then
            return p4;
        end;

        return ClientIdentifiers.ref(p4, p5, false);
    end,

    makeBridge = function(p6) -- Line: 45, Name: makeBridge
        -- upvalues: u1 (copy), ClientBridge (copy)
        if u1[p6] then
            return u1[p6];
        end;

        local v7 = ClientBridge(p6);
        u1[p6] = v7;

        return v7;
    end
};