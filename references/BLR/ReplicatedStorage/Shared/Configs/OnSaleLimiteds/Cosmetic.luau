  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage.Assets;
local KnitClient = require(ReplicatedStorage.Packages.Knit.KnitClient);
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);

local function addAccessory(p1: userdata, p2: userdata) -- Line: 7
    p1:AddAccessory(p2);
    local Handle = p2:FindFirstChild("Handle");

    if not p2:GetAttribute("WeldToHead") then
        if not (Handle and (Handle:IsA("BasePart") and not Handle:FindFirstChild("AccessoryWeld"))) then
            return;
        end;

        local v3 = Handle:FindFirstChildWhichIsA("Attachment");
        local Parent = p1.Parent;

        if Parent then
            if v3 then
                Parent = Parent:FindFirstChild(v3.Name, true);
            else
                Parent = v3;
            end;
        end;

        if not (v3 and (Parent and Parent:IsA("Attachment"))) then
            return;
        end;

        Handle.CFrame = Parent.WorldCFrame * v3.CFrame:Inverse();
        local Weld = Instance.new("Weld");
        Weld.Name = "AccessoryWeld";
        Weld.Part0 = Handle;
        Weld.Part1 = Parent.Parent;
        Weld.C0 = v3.CFrame;
        Weld.C1 = Parent.CFrame;
        Weld.Parent = Handle;

        return;
    end;

    local Head = p1.Parent:FindFirstChild("Head");
    local v4;

    if Handle then
        v4 = Handle:FindFirstChild("HatAttachment");
    else
        v4 = Handle;
    end;

    if not (Head and (Head:IsA("BasePart") and (Handle and (Handle:IsA("BasePart") and (v4 and v4:IsA("Attachment")))))) then
        warn("Unable to attach podium head cosmetic:", p2.Name);

        return;
    end;

    local HatAttachment = Head:FindFirstChild("HatAttachment");
    local v5;

    if HatAttachment then
        v5 = HatAttachment:IsA("Attachment");
    else
        v5 = HatAttachment;
    end;

    local v6 = v5 and v4.CFrame or p2.AttachmentPoint;
    local v7 = v5 and HatAttachment.CFrame or CFrame.new(0, Head.Size.Y / 2, 0);
    local AccessoryWeld = Handle:FindFirstChild("AccessoryWeld");

    if AccessoryWeld and not AccessoryWeld:IsA("Weld") then
        AccessoryWeld:Destroy();
        AccessoryWeld = nil;
    end;

    local v8 = AccessoryWeld or Instance.new("Weld");
    v8.Name = "AccessoryWeld";
    Handle.CFrame = Head.CFrame * v7 * v6:Inverse();
    v8.C0 = v6;
    v8.C1 = v7;
    v8.Part0 = Handle;
    v8.Part1 = Head;
    v8.Parent = Handle;
end;

return function(p9: string, p10: any, p11: any) -- Line: 65
    -- upvalues: makePlayerModel (copy), ReplicatedStorage (copy), addAccessory (copy), KnitClient (copy), Assets (copy)
    return {
        Type = "Cosmetic",
        HeaderOffset = 10,
        Name = p9,
        ProductId = p10,
        GiftProductId = p11,
        Gradient = script.CosmeticGradient,

        LoadVisual = function(p12, p13) -- Line: 73, Name: LoadVisual
            -- upvalues: makePlayerModel (ref), ReplicatedStorage (ref), addAccessory (ref), KnitClient (ref), Assets (ref)
            local v14 = makePlayerModel();
            v14:PivotTo(p13.Origin.CFrame);
            v14.Parent = p13;
            local Humanoid = v14.Humanoid;
            local v15 = ReplicatedStorage.Assets.Cosmetics:FindFirstChild(p12.Name);

            if v15 and v15:IsA("Accessory") then
                local v16 = v15:Clone();
                addAccessory(Humanoid, v16);

                if v16.AccessoryType == Enum.AccessoryType.Back then
                    v14:PivotTo(p13.Origin.CFrame * CFrame.Angles(0, 3.141592653589793, 0));
                end;
            else
                KnitClient.GetController("CosmeticsController"):setupCosmetic(v14, p12.Name);
            end;

            v14.Humanoid:LoadAnimation(Assets.Emotes["Banana Song"]):Play();
        end
    };
end;