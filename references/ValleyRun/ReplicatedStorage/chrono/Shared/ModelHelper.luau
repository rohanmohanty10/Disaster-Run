 

 

local script_Parent = script.Parent;
local Warn = require(script.Parent.Warn);
local Holder = require(script_Parent.Holder);
require(script_Parent.Config);
require(script_Parent.Types);
local u1 = 0;

local function CreateTempModel() -- Line: 72
    local Model = Instance.new("Model");
    Model.Name = "TempModel";
    local Part = Instance.new("Part");
    Part.Name = "Failed To Get Model";
    Part.Size = Vector3.new(3, 5, 3);
    Part.Anchored = true;
    Part.Parent = Model;
    Model.PrimaryPart = Part;
    Model.Parent = workspace;

    return Model, "CUSTOM";
end;

return {
    TAG = "CHRONO_MODEL_REPLICATOR",
    CHRONO_META_NAME = "__CHRONO_MODEL_META_ID",

    ReadyModelFromRep = function(p2: any, p3: userdata?) -- Line: 12, Name: ReadyModelFromRep
        -- upvalues: u1 (ref), Warn (copy)
        local model = p2.model;
        local modelString = p2.modelString;
        local v4 = p2.modelReplicationMode or "NATIVE";

        if v4 ~= "NATIVE" or not model then
            if v4 == "CUSTOM" then
                if modelString then
                    return modelString;
                end;

                local _CUSTOM_MODEL_REP = script.Parent.Parent.Shared._CUSTOM_MODEL_REP;

                if p3 then
                    local PlayerGui = p3.PlayerGui;
                    _CUSTOM_MODEL_REP = PlayerGui:FindFirstChild("_ChronoClientModels");

                    if not PlayerGui:FindFirstChild("_ChronoClientModels") then
                        _CUSTOM_MODEL_REP = Instance.new("ScreenGui");
                        _CUSTOM_MODEL_REP.ResetOnSpawn = false;
                        _CUSTOM_MODEL_REP.Name = "_ChronoClientModels";
                        _CUSTOM_MODEL_REP.Parent = PlayerGui;
                    end;
                end;

                if model then
                    model.Archivable = true;
                    local u5 = model:Clone();
                    u5.Parent = _CUSTOM_MODEL_REP;
                    task.delay(2, function() -- Line: 61
                        -- upvalues: u5 (copy)
                        u5:Destroy();
                    end);

                    return u5;
                end;
            elseif modelString then
                Warn.medium((`{modelString} is not a valid model string for entity {p2.id}`));
            end;

            return nil, nil;
        end;

        if p2.entityConfig.ATTACH_MODEL_META_DATA == false then
            return model;
        end;

        local v6 = model:FindFirstChild("__CHRONO_MODEL_META_INSTANCE") or Instance.new("Configuration");
        v6.Name = "__CHRONO_MODEL_META_INSTANCE";
        v6.Archivable = false;
        v6.Parent = model;
        local Attribute = v6:GetAttribute("__CHRONO_MODEL_META_ID");

        if not Attribute then
            Attribute = "CHRONO_" .. tostring(u1);
            v6:SetAttribute("__CHRONO_MODEL_META_ID", Attribute);
            v6:AddTag("CHRONO_MODEL_REPLICATOR");
            u1 = u1 + 1;
        end;

        return model, Attribute;
    end,

    CreateModelFromData = function(p7) -- Line: 88, Name: CreateModelFromData
        -- upvalues: script_Parent (copy), Holder (copy), CreateTempModel (copy)
        if p7 then
            if type(p7) == "string" then
                return p7, "CUSTOM";
            end;

            if p7.Parent ~= script_Parent._CUSTOM_MODEL_REP and not (p7.Parent and (p7.Parent.Name == "_ChronoClientModels" and (p7.Parent.Parent and p7.Parent.Parent:IsA("PlayerGui")))) then
                return p7, "NATIVE";
            end;

            local v8 = p7:Clone();

            if not v8 then
                return CreateTempModel();
            end;

            v8.Parent = Holder.GetEntityStorageInstance();

            return v8, "CUSTOM";
        end;
    end
};