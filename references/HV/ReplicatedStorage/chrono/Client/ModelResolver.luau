 

 

local CollectionService = game:GetService("CollectionService");
local Warn = require(script.Parent.Parent.Shared.Warn);
require(script.Parent.Parent.Shared.Config);
require(script.Parent.Parent.Shared.Types);
local Entity = require(script.Parent.Parent.Shared.Entity);
local ModelHelper = require(script.Parent.Parent.Shared.ModelHelper);
local TAG = ModelHelper.TAG;
local CHRONO_META_NAME = ModelHelper.CHRONO_META_NAME;
local u1 = {};
CollectionService:GetInstanceAddedSignal(TAG):Connect(function(p2: userdata) -- Line: 13, Name: OnInstanceAdded
    -- upvalues: CHRONO_META_NAME (copy), u1 (copy), Warn (copy)
    local Attribute = p2:GetAttribute(CHRONO_META_NAME);

    if Attribute then
        u1[Attribute] = p2.Parent;
        Warn.low((`Model with meta {Attribute} was added to the game. Entities using this model will now be able to resolve it.`));
    end;
end);
CollectionService:GetInstanceRemovedSignal(TAG):Connect(function(p3) -- Line: 24
    -- upvalues: CHRONO_META_NAME (copy), u1 (copy), Warn (copy)
    local Attribute = p3:GetAttribute(CHRONO_META_NAME);

    if Attribute then
        u1[Attribute] = nil;
        Warn.low((`Model with meta {Attribute} was removed from the game. Entities using this model will no longer be able to resolve it.`));
    end;
end);

for _, v in CollectionService:GetTagged(TAG) do
    local Attribute = v:GetAttribute(CHRONO_META_NAME);

    if Attribute then
        u1[Attribute] = v.Parent;
        Warn.low((`Model with meta {Attribute} was added to the game. Entities using this model will now be able to resolve it.`));
    end;
end;

return function(p4) -- Line: 37
    -- upvalues: u1 (copy), Entity (copy), Warn (copy)
    local model = p4.model;

    if model and model.Parent then
        return;
    end;

    local _modelMetaData = p4._modelMetaData;

    if not _modelMetaData then
        return;
    end;

    local v5 = u1[_modelMetaData];

    if v5 and v5 ~= model then
        Entity.SetModel(p4, v5);
        Warn.low((`Model with meta {_modelMetaData} was resolved for entity {p4.id}.`));
    end;
end;