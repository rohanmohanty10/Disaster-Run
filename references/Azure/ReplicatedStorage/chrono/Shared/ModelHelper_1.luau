 
 

local script_Parent = script.Parent;
local Warn = require(script.Parent.Warn);
local Holder = require(script_Parent.Holder);
require(script_Parent.Types);

local function CreateTempModel() -- Line: 51
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
    ReadyModelFromRep = function(p1: any, p2: userdata?) -- Line: 6, Name: ReadyModelFromRep
        -- upvalues: script_Parent (copy), Warn (copy)
        local model = p1.model;
        local modelString = p1.modelString;
        local v3 = p1.modelReplicationMode or "NATIVE";

        if v3 == "NATIVE" and model then
            return InstanceHandle.new(model);
        end;

        if v3 == "CUSTOM" then
            if modelString then
                return modelString;
            end;

            local _CUSTOM_MODEL_REP = script_Parent._CUSTOM_MODEL_REP;

            if p2 then
                local PlayerGui = p2.PlayerGui;
                _CUSTOM_MODEL_REP = PlayerGui:FindFirstChild("_ChronoClientModels");

                if not _CUSTOM_MODEL_REP then
                    _CUSTOM_MODEL_REP = Instance.new("ScreenGui");
                    _CUSTOM_MODEL_REP.ResetOnSpawn = false;
                    _CUSTOM_MODEL_REP.Name = "_ChronoClientModels";
                    _CUSTOM_MODEL_REP.Parent = PlayerGui;
                end;
            end;

            if model then
                model.Archivable = true;
                local u4 = model:Clone();
                u4.Parent = _CUSTOM_MODEL_REP;
                task.delay(2, function() -- Line: 40
                    -- upvalues: u4 (copy)
                    u4:Destroy();
                end);

                return u4;
            end;
        elseif modelString then
            Warn.medium((`{modelString} is not a valid model string for entity {p1.id}`));
        end;

        return nil;
    end,

    CreateModelFromData = function(p5) -- Line: 67, Name: CreateModelFromData
        -- upvalues: script_Parent (copy), Holder (copy), CreateTempModel (copy)
        if p5 then
            if type(p5) == "string" then
                return p5, "CUSTOM";
            end;

            if typeof(p5) == "InstanceHandle" then
                return p5:Get(), "NATIVE", p5;
            end;

            if p5.Parent ~= script_Parent._CUSTOM_MODEL_REP and not (p5.Parent and (p5.Parent.Name == "_ChronoClientModels" and (p5.Parent.Parent and p5.Parent.Parent:IsA("PlayerGui")))) then
                return p5, "NATIVE";
            end;

            local v6 = p5:Clone();

            if not v6 then
                return CreateTempModel();
            end;

            v6.Parent = Holder.GetEntityStorageInstance();

            return v6, "CUSTOM";
        end;
    end
};