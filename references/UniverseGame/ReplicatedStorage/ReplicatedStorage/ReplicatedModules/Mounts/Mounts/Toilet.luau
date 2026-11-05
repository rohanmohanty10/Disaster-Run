  

 

return {
    ItemId = "MOUNT_11",
    Inherit = "Hoverboard",

    OnSetup = function(p1) -- Line: 4, Name: OnSetup
        local Character = p1.Character;
        local Head = Character.Head;
        local Trove = p1.Trove;
        local Model = p1.Model;
        local v2 = { "NeckAttachment", "FaceFrontAttachment", "FaceCenterAttachment", "FaceFrontAttachment", "HairAttachment", "HatAttachment" };

        for _, v in Character:QueryDescendants(">Accessory") do
            local v3 = v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart");

            if v3 ~= nil then
                local v4 = false;

                for _, v5 in v2 do
                    if v3:FindFirstChild(v5) then
                        v4 = true;
                        break;
                    end;
                end;

                if v4 then
                    local v5 = Head.CFrame:Inverse() * v3.CFrame;
                    local v6 = v:Clone();
                    local Handle = v6.Handle;
                    Handle.AccessoryWeld:Destroy();
                    local Weld = Instance.new("Weld");
                    Weld.Part0 = Handle;
                    Weld.Part1 = Model.PrimaryPart;
                    Weld.C1 = v5;
                    Weld.Parent = Handle;
                    Handle.Anchored = false;
                    v6.Parent = Model;
                end;
            end;
        end;

        local v7 = Head:Clone();
        v7.Anchored = false;
        local Weld = Instance.new("Weld");
        Weld.Part0 = v7;
        Weld.Part1 = Model.PrimaryPart;
        Weld.Parent = v7;
        v7.Parent = Model;

        for _, child in Character:GetChildren() do
            if child:IsA("BasePart") or child:IsA("Accessory") then
                local SpecialMesh = Instance.new("SpecialMesh");
                SpecialMesh.Scale = Vector3.new(0, 0, 0);

                if child:IsA("Accessory") then
                    local child = child.Handle;
                end;

                SpecialMesh.Parent = child;
                Trove:Add(SpecialMesh);
            end;
        end;

        Model.PrimaryPart.Equip:Play();
    end
};