  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;

if game:GetService("RunService"):IsServer() then
    local _ = game.ServerStorage.ServerRoot;
end;

require(ReplicatedRoot.Core);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local RigUtil = require(ReplicatedRoot.Libraries.Utility.RigUtil);
local Promise = require(ReplicatedRoot.Libraries.Classes.Promise);
local u1 = {};

function u1.__index(p2, p3) -- Line: 49
    -- upvalues: u1 (copy)
    if p3 == "_WorldParent" and p2._RigParent then
        return p2._RigParent._WorldParent;
    end;

    return rawget(p2, p3) or u1[p3];
end;

function u1.new(p4, p5) -- Line: 57
    -- upvalues: u1 (copy), TableUtil (copy)
    local v6 = setmetatable({}, u1);
    local v7;

    if typeof(p4) == "Instance" and p4:IsA("ModuleScript") then
        v7 = require(p4);
    else
        v7 = typeof(p4) ~= "table" and {} or p4;
    end;

    local v8;

    if typeof(p5) == "Instance" and p5:IsA("ModuleScript") then
        v8 = require(p5);
    else
        v8 = typeof(p5) ~= "table" and {} or p5;
    end;

    local v9 = v8.Parent or v7.Parent;
    v6._RigData = TableUtil.Reconcile(v8 or {}, v7);
    v6.Name = v6._RigData.Name or "Rig";
    v6._RigParent = typeof(v9) == "table" and v9 and v9 or nil;
    v6._WorldParent = typeof(v9) == "Instance" and v9 and v9 or nil;
    v6._Children = {};
    v6._Cleanup = {};

    if v6._RigParent then
        table.insert(v6._RigParent._Children, v6);
    end;

    v6._RigModel = v6._RigData.RigModel;

    if v6._RigData.CloneRigModel then
        v6._RigModel = v6._RigModel:Clone();
    end;

    local v10 = {
        WorldParent = v6._WorldParent
    };
    local v11;

    if v6._RigParent then
        v11 = v6._RigParent._RigModel or nil;
    else
        v11 = nil;
    end;

    v10.RigParentModel = v11;
    v10.RigModel = v6._RigModel;
    v10.Joints = {};
    v6._Paths = v10;

    if v6._RigData.CloneRigModel and v6._WorldParent then
        if typeof(v6._Paths.RigParentModel) == "Instance" then
            v6._RigModel.Parent = v6._Paths.RigParentModel;
        else
            v6._RigModel.Parent = v6._WorldParent;
        end;
    end;

    v6:Init();

    if v6._RigData.UngroupRigModel then
        v6._Paths.RigModel = {};

        for _, child in pairs(v6._RigModel:GetChildren()) do
            v6._Paths.RigModel[child.Name] = child;
            child.Parent = v6._WorldParent;
        end;

        v6._RigModel:Destroy();
    end;

    return v6;
end;

function u1.GetObject(p12, p13) -- Line: 111
    -- upvalues: DirectoryUtil (copy)
    if typeof(p13) == "Instance" then
        return p13;
    end;

    if typeof(p13) == "string" then
        local v14 = string.split(p13, "/");
        local v15;

        if v14 then
            v15 = v14[1];
        else
            v15 = v14;
        end;

        local v16 = p12._Paths[v15];

        if v16 and #v14 > 1 then
            return DirectoryUtil.Get({
                Path = string.sub(p13, #v15 + 2),
                Root = v16
            });
        end;

        return v16;
    end;
end;

function u1.GetObjects(p17, p18) -- Line: 130
    local v19 = p17:GetObject(p18);

    if typeof(v19) == "table" then
        return v19;
    end;

    if typeof(v19) == "Instance" then
        return v19:GetChildren();
    end;
end;

local u47 = {
    Swap = function(p20, p21) -- Line: 140, Name: Swap
        -- upvalues: RigUtil (copy)
        p21.Rig = p20:GetObject(p21.Rig);
        p21.TargetRig = p20:GetObject(p21.TargetRig);
        local v22 = RigUtil.SwapRig(p21);

        if v22 then
            for _, v in pairs(v22) do
                table.insert(p20._Cleanup, v);
            end;
        end;
    end,

    Bind = function(p23, p24) -- Line: 151, Name: Bind
        -- upvalues: RigUtil (copy)
        p24.Rig = p23:GetObject(p24.Rig);
        p24.TargetRig = p23:GetObject(p24.TargetRig);
        local v25, v26 = RigUtil.BindRig(p24);

        if v25 then
            for _, v in pairs(v25) do
                table.insert(p23._Cleanup, v);
            end;
        end;

        if v26 and p24.HidePivots then
            for _, child in pairs(v26:GetChildren()) do
                child.Transparency = 1;
            end;
        end;
    end,

    Generate = function(p27, p28) -- Line: 169, Name: Generate
        -- upvalues: TableUtil (copy), RigUtil (copy)
        local v29 = TableUtil.Copy(p28, true);

        if v29.Joints then
            for _, v in pairs(v29.Joints) do
                if typeof(v.Root) == "string" then
                    v.Root = p27:GetObject(v.Root);
                end;

                if typeof(v.Target) == "string" then
                    v.Target = p27:GetObject(v.Target);
                end;
            end;
        end;

        local v30 = RigUtil.GenerateRig(v29);

        for _, v in pairs(v30.Motors) do
            table.insert(p27._Cleanup, v);
        end;
    end,

    WeldModel = function(p31, p32) -- Line: 188, Name: WeldModel
        -- upvalues: RigUtil (copy)
        local v33 = p31:GetObject(p32.Model) or p31._RigModel;
        RigUtil.WeldModel(v33, p32);
    end,

    CreateJoint = function(p34, p35) -- Line: 193, Name: CreateJoint
        local v36 = p34:GetObject(p35.Part0);
        local v37 = p34:GetObject(p35.Part1);
        local v38 = Instance.new(p35.ClassName or "Weld");
        v38.Name = p35.Name or (v36 and (v36.Name or "NULL") or "NULL") .. "_" .. (v37 and (v37.Name or "NULL") or "NULL");
        v38.Part0 = v36;
        v38.Part1 = v37;

        if v38:IsA("JointInstance") then
            v38.C0 = p35.C0 or v38.C0;
            v38.C0 = p35.C1 or v38.C1;
        end;

        v38.Parent = v38.Parent == "Part0" and v36 and v36 or (v38.Parent == "Part1" and v37 and v37 or v36);
        p34._Paths.Joints[p35.Name] = v38;
    end,

    EditModel = function(p39, p40) -- Line: 208, Name: EditModel
        -- upvalues: Promise (copy), RigUtil (copy)
        local u41 = p39:GetObject(p40.Model) or p39._RigModel;
        local Physics = p40.Physics;
        local Face = p40.Face;
        local Accessories = p40.Accessories;
        local Clothing = p40.Clothing;
        local BodyTransparency = p40.BodyTransparency;
        local u42 = game.Players:GetPlayerFromCharacter(u41);
        Promise.new(function(p43, p44) -- Line: 218
            -- upvalues: Physics (copy), RigUtil (ref), u41 (copy), BodyTransparency (copy), Face (copy), Accessories (copy), Clothing (copy), u42 (copy), Promise (ref)
            if Physics then
                RigUtil.SetPhysics(u41, Physics);
            end;

            if typeof(BodyTransparency) == "number" or typeof(BodyTransparency) == "table" then
                RigUtil.SetBodyTransparency(u41, BodyTransparency);
            end;

            local function EditAvatar() -- Line: 226
                -- upvalues: Face (ref), RigUtil (ref), u41 (ref), Accessories (ref), Clothing (ref)
                if Face == false then
                    RigUtil.RemoveFace(u41);
                elseif typeof(Face) == "number" then
                    RigUtil.SetFaceVisible(u41, Face);
                end;

                if Accessories ~= nil then
                    RigUtil.EditAccessories(u41, Accessories);
                end;

                if Clothing ~= nil then
                    RigUtil.EditClothing(u41, Clothing);
                end;
            end;

            if not u42 then
                EditAvatar();

                return;
            end;

            Promise.retryWithDelay(function() -- Line: 241
                -- upvalues: Promise (ref), u42 (ref)
                return Promise.new(function(p45, p46) -- Line: 242
                    -- upvalues: u42 (ref)
                    if u42:HasAppearanceLoaded() then
                        p45();

                        return;
                    end;

                    p46();
                end);
            end, 10, 1):await();
            EditAvatar();
            task.wait(0.5);
            EditAvatar();
            task.wait(0.5);
            EditAvatar();
            task.wait(0.5);
        end):catch(warn);
    end
};

function u1.Init(p48) -- Line: 261
    -- upvalues: u47 (copy)
    local v49 = {};

    for _, v in pairs(p48._RigData.Operations or {}) do
        table.insert(v49, v);
    end;

    table.sort(v49, function(p50, p51) -- Line: 266
        return (p50.Priority or 0) < (p51.Priority or 0);
    end);

    for _, v in pairs(v49) do
        if u47[v.Type] then
            u47[v.Type](p48, v);
        end;
    end;
end;

function u1.Destroy(p52) -- Line: 276
    if table.isfrozen(p52) then
        return;
    end;

    p52._WorldParent = nil;
    p52._Paths.WorldParent = nil;

    for _, v in pairs(p52._Cleanup) do
        v:Destroy();
    end;

    if p52._RigModel then
        p52._RigModel:Destroy();
    end;

    if typeof(p52._Paths.RigModel) == "table" then
        for _, v in pairs(p52._Paths.RigModel) do
            v:Destroy();
        end;
    end;

    p52._RigData = nil;

    for _, v in pairs(p52._Children) do
        v:Destroy();
    end;

    if p52._RigParent then
        for i, v in pairs(p52._RigParent._Children) do
            if v == p52 then
                table.remove(p52._RigParent._Children, i);
            end;
        end;

        p52._RigParent = nil;
        p52._Paths.RigParentModel = nil;
    end;

    table.clear(p52);
    table.freeze(p52);
end;

return u1;