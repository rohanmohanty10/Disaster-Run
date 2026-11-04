  

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");

return {
    SetupCosmetic = function(p1: userdata, p2: any) -- Line: 12, Name: SetupCosmetic
        -- upvalues: CollectionService (copy), RunService (copy)
        if p1:FindFirstChild("FollowingPlanets") then
            return;
        end;

        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local Folder = Instance.new("Folder");
        Folder.Name = "FollowingPlanets";
        Folder.Parent = p1;
        CollectionService:AddTag(Folder, (`Cosmetic{p2}`));

        for _, child in script["Pumpkin Army"]:GetChildren() do
            if child:IsA("Model") then
                local v3 = child:Clone();
                v3:PivotTo(HumanoidRootPart.CFrame * script.Root.CFrame:ToObjectSpace(child:GetPivot()));
                v3.Parent = Folder;
            elseif child:IsA("BasePart") then
                local v4 = child:Clone();
                v4.CFrame = HumanoidRootPart.CFrame * script.Root.CFrame:ToObjectSpace(child.CFrame);
                v4.Parent = Folder;
            end;
        end;

        local Children = Folder:GetChildren();
        local u5 = {};

        for i, v in ipairs(Children) do
            if v:IsA("Model") then
                local v6 = {
                    IsModel = true,
                    Inst = v,
                    LocalCF = HumanoidRootPart.CFrame:ToObjectSpace(v:GetPivot()),
                    Phase = (i - 1) * 0.7
                };
                table.insert(u5, v6);
            elseif v:IsA("BasePart") then
                local v7 = {
                    IsModel = false,
                    Inst = v,
                    LocalCF = HumanoidRootPart.CFrame:ToObjectSpace(v.CFrame),
                    Phase = (i - 1) * 0.7
                };
                table.insert(u5, v7);
            end;
        end;

        local u8 = nil;
        u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 60
            -- upvalues: Folder (copy), HumanoidRootPart (copy), u8 (ref), u5 (copy)
            if not (Folder.Parent and HumanoidRootPart.Parent) then
                if u8 then
                    u8:Disconnect();
                end;

                return;
            end;

            local os_clock_ret = os.clock();

            for _, v in ipairs(u5) do
                local v10 = HumanoidRootPart.CFrame * v.LocalCF;
                local v11 = math.sin(3.141592653589793 * os_clock_ret + v.Phase) * 0.5;
                local v12 = v10 * CFrame.new(0, v11, 0);

                if v.IsModel then
                    v.Inst:PivotTo(v12);
                else
                    v.Inst.CFrame = v12;
                end;
            end;
        end);
    end
};