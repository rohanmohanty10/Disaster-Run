 
 

local u5 = {
    HolderName = "__REPLICATOR_LOCK",

    _setNetworkOwner = function(p1: userdata, p2: userdata?) -- Line: 11, Name: _setNetworkOwner
        if p1:CanSetNetworkOwnership() then
            p1:SetNetworkOwner(p2);
        end;
    end,

    get = function(p3: userdata) -- Line: 17, Name: get
        local __REPLICATOR_LOCK = p3:FindFirstChild("__REPLICATOR_LOCK");
        local v4;

        if __REPLICATOR_LOCK then
            v4 = __REPLICATOR_LOCK:FindFirstChild("Locker");
        else
            v4 = nil;
        end;

        if v4 and v4:IsA("BasePart") then
            return v4;
        end;

        return nil;
    end
};

function u5.apply(p6: userdata, p7: userdata?) -- Line: 23
    -- upvalues: u5 (copy)
    u5.remove(p6);
    u5._setNetworkOwner(p6, p7);
    local CFrame = p6.CFrame;
    local Camera = Instance.new("Camera");
    Camera.Name = "__REPLICATOR_LOCK";
    Camera.Archivable = false;
    local Part = Instance.new("Part");
    Part.Name = "Locker";
    Part.Size = Vector3.new(0, 0, 0);
    Part.Transparency = 1;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Massless = false;
    Part.RootPriority = 127;
    Part.CustomPhysicalProperties = PhysicalProperties.new(0.0001, 0, 0, 0, 0);
    Part.CFrame = CFrame;
    Part.Parent = Camera;
    local Weld = Instance.new("Weld");
    Weld.Name = "Weld";
    Weld.Part0 = Part;
    Weld.Part1 = p6;
    Weld.Parent = Camera;
    Camera.Parent = p6;
    p6.CFrame = CFrame;
    u5._setNetworkOwner(Part, p7);
    Part.Anchored = true;

    return Part;
end;

function u5.setOwner(p8: userdata, p9: userdata?) -- Line: 60
    -- upvalues: u5 (copy)
    return u5.apply(p8, p9);
end;

function u5.setCFrame(p10: userdata, p11) -- Line: 64
    -- upvalues: u5 (copy)
    local v12 = u5.get(p10);

    if v12 then
        v12.CFrame = p11;

        return;
    end;

    p10.CFrame = p11;
end;

function u5.remove(p13: userdata) -- Line: 73
    local __REPLICATOR_LOCK = p13:FindFirstChild("__REPLICATOR_LOCK");

    if __REPLICATOR_LOCK then
        local CFrame = p13.CFrame;
        __REPLICATOR_LOCK:Destroy();
        p13.CFrame = CFrame;
    end;
end;

return u5;