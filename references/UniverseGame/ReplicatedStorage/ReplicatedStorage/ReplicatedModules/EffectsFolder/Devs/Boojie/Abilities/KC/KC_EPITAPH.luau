  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);

return function(u1, p2, p3) -- Line: 13
    -- upvalues: Knit (copy), Trove (copy), AssetHandler (copy), ParticleHandler (copy)
    local Head = u1:FindFirstChild("Head");

    if not Head then
        return;
    end;

    local Stand = u1:FindFirstChild("Stand");

    if Stand then
        Stand = Stand:FindFirstChild("Stand Head");
    end;

    local _Epitaph = u1:FindFirstChild("_Epitaph");
    local u4 = nil;

    if not p2 then
        if _Epitaph then
            _Epitaph:Destroy();
        end;

        return;
    end;

    if _Epitaph then
        return;
    end;

    local function GetHead() -- Line: 34
        -- upvalues: Knit (ref), u1 (copy), Stand (copy), Head (copy)
        return Knit.CollectionService:HasTag(u1, "Summoned") and Stand or Head;
    end;

    local function SetVisible() -- Line: 38
        -- upvalues: Knit (ref), u1 (copy), _Epitaph (ref), u4 (ref)
        if Knit.CollectionService:HasTag(u1, "Summoned") then
            _Epitaph.FAKE.Transparency = 1;
            _Epitaph.FAKE.FAKE.Transparency = 1;
            u4.C1 = CFrame.new(0, 0, 0);

            return;
        end;

        _Epitaph.FAKE.Transparency = 0;
        _Epitaph.FAKE.FAKE.Transparency = 0;
        u4.C1 = CFrame.new(0, 0.2, 0.01) * CFrame.Angles(-0.6108652381980153, 0, 0);
    end;

    local u5 = Trove.new();
    _Epitaph = AssetHandler.GetAsset("Particles/EpitaphHead", p3):Clone();
    ParticleHandler.Unusualify(_Epitaph, {
        Character = u1
    });
    _Epitaph.Name = "_Epitaph";
    u4 = Instance.new("Weld");
    u4.Part0 = Knit.CollectionService:HasTag(u1, "Summoned") and Stand and Stand or Head;
    u4.Part1 = _Epitaph;
    u4.Parent = Head;
    SetVisible();
    local v6 = ParticleHandler.GetSkinInfo(p3.SkinName);
    local v7 = nil;

    if v6 then
        if v6.DebrisTrail and v6.DebrisTrail.HSVShift then
            v7 = v6.DebrisTrail.HSVShift;
        elseif v6.Metadata and v6.Metadata.HSVShift then
            v7 = v6.Metadata.HSVShift;
        end;

        ParticleHandler.HSVShiftParticles(_Epitaph, v7 or {});
    end;

    _Epitaph.Parent = u1;
    u5:AttachToInstance(_Epitaph);
    u5:Connect(Knit.CollectionService:GetInstanceAddedSignal("Summoned"), function(p8) -- Line: 78
        -- upvalues: u1 (copy), u4 (ref), Knit (ref), Stand (copy), Head (copy), SetVisible (copy)
        if p8 == u1 then
            u4.Part0 = Knit.CollectionService:HasTag(u1, "Summoned") and Stand or Head;
            SetVisible();
        end;
    end);
    u5:Connect(Knit.CollectionService:GetInstanceRemovedSignal("Summoned"), function(p9) -- Line: 85
        -- upvalues: u1 (copy), u4 (ref), Knit (ref), Stand (copy), Head (copy), SetVisible (copy)
        if p9 == u1 then
            u4.Part0 = Knit.CollectionService:HasTag(u1, "Summoned") and Stand or Head;
            SetVisible();
        end;
    end);
    u5:Connect(u1.AncestryChanged, function() -- Line: 92
        -- upvalues: u1 (copy), u5 (copy)
        if not u1:IsDescendantOf(workspace) then
            u5:Destroy();
        end;
    end);
end;