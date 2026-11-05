  

 

local CollectionService = game:GetService("CollectionService");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Components = script:WaitForChild("Components");
local Dependencies = script:WaitForChild("Dependencies");
local CeiveImOverlay = require(Dependencies:WaitForChild("CeiveImOverlay"));
local Config = require(Dependencies:WaitForChild("Config"));
local Frustum = require(Dependencies:WaitForChild("Frustum"));
local Utilities = require(Dependencies:WaitForChild("Utilities"));
local u1 = nil;
local Bone = require(Components:WaitForChild("Bone"));
local BoneTree = require(Components:WaitForChild("BoneTree"));
local ColliderObject = require(Components:WaitForChild("Collision"):WaitForChild("ColliderObject"));
local Runtime = Dependencies:WaitForChild("Runtime");

local function CopyPasteAttributes(p2, p3) -- Line: 22
    for i, v in p2:GetAttributes() do
        p3:SetAttribute(i, v);
    end;
end;

local SB_INDENT_LOG = Utilities.SB_INDENT_LOG;
local SB_UNINDENT_LOG = Utilities.SB_UNINDENT_LOG;
local SB_VERBOSE_LOG = Utilities.SB_VERBOSE_LOG;
local SB_VERBOSE_WARN = Utilities.SB_VERBOSE_WARN;
local u4 = {};
u4.__index = u4;

function u4.new() -- Line: 73
    -- upvalues: HttpService (copy), u4 (copy)
    local v5 = {
        ShouldDestroy = false,
        ID = HttpService:GenerateGUID(false),
        BoneTrees = {},
        ColliderObjects = {}
    };

    return setmetatable(v5, u4);
end;

function u4.m_AppendBone(p6, p7, p8, p9, p10) -- Line: 96
    -- upvalues: Utilities (copy), Bone (copy), SB_VERBOSE_LOG (copy)
    local v11 = Utilities.GatherBoneSettings(p8);
    local v12 = Bone.new(p8, p7.Root, p7.RootPart);

    for i, v in v11 do
        if v == "¬" or not v then
            local v = nil;
        end;

        v12[i] = v;
    end;

    local v13 = p7.Bones[p9];

    if p9 > 0 then
        local Magnitude = (v13.Position - v12.Position).Magnitude;
        v12.FreeLength = Magnitude;
        v12.Weight = Magnitude * 0.7;
        v12.HeirarchyLength = p10;
        v13.HasChild = true;
    end;

    if p10 <= p7.Settings.AnchorDepth then
        SB_VERBOSE_LOG("Anchoring bone");
        v12.Anchored = true;
    end;

    v12.ParentIndex = p9;
    table.insert(p7.Bones, v12);
end;

function u4.m_CreateBoneTree(u14, p15, p16) -- Line: 134
    -- upvalues: Utilities (copy), BoneTree (copy), SB_VERBOSE_LOG (copy), SB_INDENT_LOG (copy), SB_UNINDENT_LOG (copy)
    local v17 = Utilities.GatherObjectSettings(p15);
    local u18 = BoneTree.new(p16, p15);
    u18.Settings = v17;
    SB_VERBOSE_LOG((`Creating bone tree {p15.Name}; {p16.Name}`));
    SB_INDENT_LOG();

    local function AddChildren(p19, p20, p21) -- Line: 143
        -- upvalues: SB_VERBOSE_LOG (ref), SB_INDENT_LOG (ref), u14 (copy), u18 (copy), AddChildren (copy), SB_UNINDENT_LOG (ref)
        SB_VERBOSE_LOG((`Adding bone: {p19.Name}; {p20}; {p21}`));
        SB_INDENT_LOG();
        local v22 = p19:GetChildren();

        for _, v in v22 do
            if v:IsA("Bone") then
                u14:m_AppendBone(u18, v, p20, p21);
                AddChildren(v, #u18.Bones, p21 + 1);
            end;
        end;

        if #v22 == 0 then
            SB_VERBOSE_LOG("Adding tail bone");
            local Parent = p19.Parent;
            local v23 = Parent:IsA("Bone") and Parent.WorldPosition or Parent.Position;
            local v24 = p19.WorldCFrame + p19.WorldCFrame.UpVector.Unit * (p19.WorldPosition - v23).Magnitude;
            local Bone2 = Instance.new("Bone");
            Bone2.Parent = p19;
            Bone2.Name = p19.Name .. "_Tail";
            Bone2.WorldCFrame = v24;

            for i, v in p19:GetAttributes() do
                Bone2:SetAttribute(i, v);
            end;

            u14:m_AppendBone(u18, Bone2, #u18.Bones, p21);
        end;

        SB_UNINDENT_LOG();
    end;

    u14:m_AppendBone(u18, p16, 0, 0);
    AddChildren(p16, 1, 1);
    table.insert(u14.BoneTrees, u18);
    SB_UNINDENT_LOG();
end;

function u4.m_UpdateViewFrustum(p25) -- Line: 190
    -- upvalues: Frustum (copy), Config (copy)
    debug.profilebegin("SmartBone2::m_UpdateViewFrustum");
    local v26, v27, v28, v29, v30, v31, v32, v33, v34 = Frustum.GetCFrames(workspace.CurrentCamera, Config.FAR_PLANE);

    for _, v in p25.BoneTrees do
        debug.profilebegin("BoneTree::m_UpdateViewFrustum");
        v.InView = Frustum.ObjectInFrustum({
            CFrame = v.BoundingBoxCFrame,
            Size = v.BoundingBoxSize
        }, v26, v27, v28, v29, v30, v31, v32, v33, v34);
        debug.profileend();
    end;

    debug.profileend();
end;

function u4.m_CleanColliders(p35) -- Line: 206
    -- upvalues: SB_VERBOSE_WARN (copy), SB_INDENT_LOG (copy), SB_UNINDENT_LOG (copy)
    debug.profilebegin("Clean Colliders");

    if #p35.ColliderObjects ~= 0 then
        for i, v in p35.ColliderObjects do
            if #v.Colliders == 0 or v.Destroyed == true then
                SB_VERBOSE_WARN("Deleting Collider Object");
                SB_INDENT_LOG();
                v:Destroy();
                SB_UNINDENT_LOG();
                table.remove(p35.ColliderObjects, i);
            end;
        end;
    end;

    debug.profileend();
end;

function u4.m_ConstrainBoneTree(p36, p37, p38) -- Line: 230
    debug.profilebegin("SmartBone2::m_ConstrainBoneTree");
    p37:Constrain(p36.ColliderObjects, p38);
    debug.profileend();
end;

function u4.m_UpdateBoneTree(p39, p40, p41, p42) -- Line: 247
    -- upvalues: SB_VERBOSE_LOG (copy)
    debug.profilebegin("SmartBone2::m_UpdateBoneTree");

    if p40.Destroyed then
        p40:Destroy();
        table.remove(p39.BoneTrees, p41);

        return;
    end;

    p40:PreUpdate(p42);

    if not p40.InView or math.floor(p40.UpdateRate) == 0 then
        local FirstSkipUpdate = p40.FirstSkipUpdate;
        p40:SkipUpdate();

        if not FirstSkipUpdate then
            debug.profileend();
            task.synchronize();
            p40:ApplyTransform();
            SB_VERBOSE_LOG((`Skipping BoneTree, InView: {p40.InView}, Update Rate == 0: {math.floor(p40.UpdateRate) == 0}`));
        end;

        return;
    end;

    debug.profilebegin("Step Colliders");

    for _, v in p39.ColliderObjects do
        v:Step();
    end;

    debug.profileend();
    local v43 = 1 / p40.UpdateRate;
    p40.AccumulatedDelta = p40.AccumulatedDelta + p42;
    local v44 = false;

    while v43 < p40.AccumulatedDelta do
        p40.AccumulatedDelta = p40.AccumulatedDelta - v43;
        p40:StepPhysics(v43);
        p39:m_ConstrainBoneTree(p40, p42);
        p40:SolveTransform(v43);
        v44 = true;
    end;

    debug.profileend();

    if v44 then
        task.synchronize();
        p40:ApplyTransform();
    end;
end;

function u4.m_CheckDestroy(p45) -- Line: 310
    p45.ShouldDestroy = false;

    if #p45.BoneTrees ~= 0 then
        return false;
    end;

    p45.ShouldDestroy = true;

    return true;
end;

function u4.LoadObject(p46, p47) -- Line: 326
    local v48 = p47:GetAttribute("Roots");

    if not v48 then
        warn((`[SmartBone2::LoadObject] Cannot load an object with no roots defined {p47.Name}`));

        return;
    end;

    local v49 = v48:split(",");
    local v50 = {};

    for _, descendant in p47:GetDescendants() do
        if descendant:IsA("Bone") then
            if v50[descendant.Name] then
                warn((`[SmartBone2::LoadObject] Duplicate bones of name: {descendant.Name} in RootPart: {p47.Name}`));
            else
                v50[descendant.Name] = descendant;
            end;
        end;
    end;

    for _, v in v49 do
        local v51 = v50[v];

        if v51 then
            p46:m_CreateBoneTree(p47, v51);
        else
            warn((`[SmartBone2::LoadObject] Couldn't find Root Bone of name: {v} in RootPart: {p47.Name}`));
        end;
    end;
end;

function u4.LoadColliderModule(p52, p53, p54) -- Line: 367
    -- upvalues: HttpService (copy), ColliderObject (copy)
    assert(p53, "[SmartBone2::LoadColliderModule] No collider module passed in");
    local v55 = HttpService:JSONDecode((require(p53)));
    local v56 = ColliderObject.new(v55, p54);
    table.insert(p52.ColliderObjects, v56);
end;

function u4.LoadRawCollider(p57, p58, p59) -- Line: 382
    -- upvalues: ColliderObject (copy)
    local v60 = ColliderObject.new(p58, p59);
    table.insert(p57.ColliderObjects, v60);
end;

function u4.SkipUpdate(p61) -- Line: 390
    debug.profilebegin("SmartBone2::SkipUpdate");

    for _, v in p61.BoneTrees do
        v:SkipUpdate();
    end;

    debug.profileend();
end;

function u4.StepBoneTrees(p62, p63) -- Line: 401
    -- upvalues: SB_VERBOSE_WARN (copy)
    if p62:m_CheckDestroy() then
        return;
    end;

    if p63 <= 0 then
        SB_VERBOSE_WARN("DeltaTime is zero or sub zero, not updating.");

        return;
    end;

    p62:m_CleanColliders();
    p62:m_UpdateViewFrustum();

    for i, v in p62.BoneTrees do
        p62:m_UpdateBoneTree(v, i, p63);
    end;
end;

function u4.DrawDebug(p64, p65, p66, p67, p68, p69, p70, p71, p72, p73, p74, p75, p76, p77) -- Line: 434
    for _, v in p64.BoneTrees do
        v:DrawDebug(p66, p67, p68, p69, p70, p75, p76, p77);
    end;

    if p65 then
        for _, v in p64.ColliderObjects do
            v:DrawDebug(p71, p72, p73, p74);
        end;
    end;
end;

function u4.DrawOverlay(p78, p79) -- Line: 473
    -- upvalues: Config (copy)
    if not Config.DEBUG_OVERLAY_ENABLED then
        return;
    end;

    local v80 = Color3.new(1, 0.431373, 0.713725);
    local v81 = Color3.new(1, 1, 1);
    local v82 = Color3.new(0.486275, 0.431373, 1);
    local v83 = Color3.new(1, 1, 1);
    p79.Begin(`SmartBone Instance ID: {p78.ID}`, v80, v81);
    p79.Text((`Frame Counter: {shared.FrameCounter}`));

    if Config.DEBUG_OVERLAY_TREE then
        for i, v in p78.BoneTrees do
            if Config.DEBUG_OVERLAY_MAX_TREES > 0 and Config.DEBUG_OVERLAY_TREE_OFFSET + Config.DEBUG_OVERLAY_MAX_TREES <= i then
                break;
            end;

            if i >= Config.DEBUG_OVERLAY_TREE_OFFSET then
                p79.Begin(`Bone Tree {i}`, v82, v83);
                v:DrawOverlay(p79);
                p79.End();
            end;
        end;
    end;

    p79.End();
end;

function u4.Destroy(p84) -- Line: 509
    -- upvalues: SB_VERBOSE_LOG (copy)
    SB_VERBOSE_LOG("Deleting SmartBone Object");

    for _, v in p84.BoneTrees do
        v:Destroy();
    end;

    for _, v in p84.ColliderObjects do
        v:Destroy();
    end;

    setmetatable(p84, nil);
end;

function u4.Start() -- Line: 527
    -- upvalues: RunService (copy), u4 (copy), Config (copy), Players (copy), u1 (ref), CollectionService (copy), SB_VERBOSE_LOG (copy), SB_INDENT_LOG (copy), Utilities (copy), Runtime (copy), SB_UNINDENT_LOG (copy), CeiveImOverlay (copy)
    if not RunService:IsClient() then
        warn("Smartbone.Start() can only be called in client context.");

        return;
    end;

    if not u4.Running then
        if Config.STARTUP_PRINT_ENABLED or Config.LOG_VERBOSE then
            print((`SmartBone2 v{Config.VERSION} Starting`));
        end;

        u4.Running = true;
        local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts");
        local Folder = Instance.new("Folder");
        Folder.Name = "SmartBone-Actors";
        Folder.Parent = PlayerScripts;
        local BindableEvent = Instance.new("BindableEvent");
        BindableEvent.Name = "OverlayEvent";
        BindableEvent.Parent = script;
        BindableEvent.Event:Connect(function(p85, ...) -- Line: 555
            -- upvalues: Config (ref), u1 (ref)
            if not Config.DEBUG_OVERLAY_ENABLED then
                return;
            end;

            if p85 == "Text" then
                u1:Text(...);

                return;
            end;

            if p85 == "Begin" then
                u1:Begin(...);

                return;
            end;

            if p85 == "End" then
                u1:End();
            end;
        end);

        local function GatherColliders() -- Line: 569
            -- upvalues: CollectionService (ref), SB_VERBOSE_LOG (ref), Config (ref)
            local v86 = {
                Key = {},
                Raw = {}
            };

            for _, v in CollectionService:GetTagged("SmartCollider") do
                if v:IsA("BasePart") then
                    local v87 = v:GetAttribute("ColliderKey");

                    if v87 then
                        v87 = tostring(v87);

                        if not v86.Key[v87] then
                            v86.Key[v87] = {};
                        end;

                        table.insert(v86.Key[v87], v);
                    end;

                    SB_VERBOSE_LOG((`Adding collider: {v.Name}, Collider Key: {v87}`));
                    table.insert(v86.Raw, v);

                    if Config.YIELD_ON_COLLIDER_GATHER then
                        task.wait();
                    end;
                end;
            end;

            return v86;
        end;

        local function SetupObject(p88) -- Line: 603
            -- upvalues: SB_VERBOSE_LOG (ref), SB_INDENT_LOG (ref), GatherColliders (copy), Utilities (ref), Runtime (ref), Folder (copy), SB_UNINDENT_LOG (ref)
            if not p88:IsA("BasePart") then
                return;
            end;

            if not p88:IsDescendantOf(workspace) or p88:FindFirstAncestorWhichIsA("ViewportFrame") then
                return;
            end;

            SB_VERBOSE_LOG((`Setup Object: {p88.Name}`));
            SB_INDENT_LOG();
            local v89 = GatherColliders();
            local v90 = p88:GetAttribute("ColliderKey");
            local v91;

            if v90 then
                v91 = v89.Key[tostring(v90)] or {};
            else
                v91 = v89.Raw or {};
            end;

            local v92 = {};

            for _, v in v91 do
                local v93 = { Utilities.GetCollider(v), v };
                table.insert(v92, v93);
            end;

            local Actor = Instance.new("Actor");
            local v94 = Runtime:Clone();
            v94.Parent = Actor;
            v94.Enabled = true;
            Actor.Parent = Folder;
            task.wait();
            Actor:SendMessage("Setup", p88, v92, script);
            SB_VERBOSE_LOG("Runtime Started");
            SB_UNINDENT_LOG();
        end;

        CollectionService:GetInstanceAddedSignal("SmartBone"):Connect(SetupObject);

        for _, v in CollectionService:GetTagged("SmartBone") do
            SetupObject(v);
        end;

        if Config.DEBUG_OVERLAY_ENABLED then
            u1 = CeiveImOverlay.new();
            local PlayerGui = Players.LocalPlayer.PlayerGui;
            local ScreenGui = Instance.new("ScreenGui");
            ScreenGui.Name = "SmartBoneDebugOverlay";
            ScreenGui.IgnoreGuiInset = true;
            ScreenGui.ResetOnSpawn = false;
            ScreenGui.Parent = PlayerGui;
            u1.BackFrame.Parent = ScreenGui;
            RunService.RenderStepped:Connect(function() -- Line: 664
                -- upvalues: u1 (ref)
                u1:Render();
            end);
        end;

        return {
            Stop = function() -- Line: 670, Name: Stop
                -- upvalues: Config (ref), Folder (copy)
                if Config.RESET_BONE_ON_DESTROY then
                    for _, child in Folder:GetChildren() do
                        child:SendMessage("Destroy");
                    end;

                    return;
                end;

                Folder:Destroy();
            end
        };
    end;

    warn("Cannot call Smartbone.Start() multiple times");
end;

return u4;