  

 

return {
    Init = function(p1) -- Line: 5, Name: Init
        local TweenService = game:GetService("TweenService");
        local PartCache = require(script.PartCache);
        local v2 = {};
        v2.__index = v2;
        local u3 = {
            MaxElevation = 100,
            MinRange = 5,
            MaxRange = 20,
            Rings = 3,
            Frequency = 8,
            CanCollide = false,
            FadeIn = 0.5,
            FadeOut = 0.8,
            Duration = nil,
            Blacklist = nil,
            CollisionGroup = "Default",
            Whitelist = { workspace.Map },
            Parent = workspace.Effects
        };
        local u4 = {
            Enum.NormalId.Front,
            Enum.NormalId.Back,
            Enum.NormalId.Left,
            Enum.NormalId.Right,
            Enum.NormalId.Top,
            Enum.NormalId.Bottom
        };
        local u17 = {
            [Enum.Material.Grass] = function(p5, p6, p7, p8) -- Line: 39
                p5.Material = Enum.Material.Ground;
                p5.Color = Color3.fromRGB(106, 74, 45);
                p5.CollisionGroup = p8;
            end,

            [Enum.Material.Sand] = function(u9, p10, p11, p12) -- Line: 45
                -- upvalues: TweenService (copy)
                u9.Material = Enum.Material.Sand;
                u9.Color = p11;
                u9.Anchored = false;
                u9.CanCollide = true;
                u9.CollisionGroup = p12;
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = u9;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Attachment0 = Attachment;
                LinearVelocity.MaxForce = (1 / 0);
                LinearVelocity.VectorVelocity = u9.CFrame.UpVector * 60;
                LinearVelocity.Parent = u9;
                task.delay(0.05, function() -- Line: 61
                    -- upvalues: LinearVelocity (copy), Attachment (copy)
                    LinearVelocity:Destroy();
                    Attachment:Destroy();
                end);
                TweenService:Create(u9, TweenInfo.new(math.random(2, 3), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
                task.delay(3, function() -- Line: 66
                    -- upvalues: u9 (copy)
                    u9.Anchored = true;
                end);
            end,

            [Enum.Material.Snow] = function(u13, p14, p15, p16) -- Line: 69
                -- upvalues: TweenService (copy)
                u13.Material = Enum.Material.Sand;
                u13.Color = p15;
                u13.Anchored = false;
                u13.CanCollide = true;
                u13.CollisionGroup = p16;
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = u13;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.Attachment0 = Attachment;
                LinearVelocity.MaxForce = (1 / 0);
                LinearVelocity.VectorVelocity = u13.CFrame.UpVector * 60;
                LinearVelocity.Parent = u13;
                task.delay(0.05, function() -- Line: 85
                    -- upvalues: LinearVelocity (copy), Attachment (copy)
                    LinearVelocity:Destroy();
                    Attachment:Destroy();
                end);
                TweenService:Create(u13, TweenInfo.new(math.random(1, 3), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
                task.delay(6, function() -- Line: 91
                    -- upvalues: u13 (copy)
                    u13.Anchored = true;
                end);
            end
        };
        local Folder = Instance.new("Folder");
        Folder.Name = "RockCache";
        Folder.Parent = workspace;
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.TopSurface = Enum.SurfaceType.Smooth;
        Part.BottomSurface = Enum.SurfaceType.Smooth;
        local u18 = PartCache.new(Part, 50, Folder);
        Part:Destroy();

        local function buildRaycastParams(p19, p20) -- Line: 130
            local v21 = RaycastParams.new();

            if p19 then
                v21.FilterDescendantsInstances = p19;
                v21.FilterType = Enum.RaycastFilterType.Include;

                return v21;
            end;

            if p20 then
                v21.FilterDescendantsInstances = p20;
                v21.FilterType = Enum.RaycastFilterType.Exclude;

                return v21;
            end;

            v21.FilterDescendantsInstances = { workspace };
            v21.FilterType = Enum.RaycastFilterType.Include;

            return v21;
        end;

        local function computeRockSize(p22, p23) -- Line: 145
            local v24 = p22 / (p23 / 2);
            local v25 = v24 * (math.random(15, 40) / 10);
            local v26 = v24 * (math.random(15, 40) / 10);

            return Vector3.new(v25, v26, v24);
        end;

        local function applyTextures(p27, p28) -- Line: 154
            -- upvalues: u4 (copy)
            local v29 = nil;

            for _, child in p27:GetChildren() do
                if child:IsA("Texture") or child:IsA("Decal") then
                    v29 = child;
                    break;
                end;
            end;

            if v29 then
                for _, v in u4 do
                    local v30 = v29:Clone();
                    v30.Face = v;
                    v30.Parent = p28;
                end;
            end;
        end;

        local function copyAppearance(p31, p32, p33, p34) -- Line: 172
            -- upvalues: u17 (copy), applyTextures (copy)
            local v35 = u17[p31.Material];

            if v35 then
                v35(p32, p33, p31.Color, p34);

                return;
            end;

            p32.Material = p31.Material;
            p32.Color = p31.Color;
            p32.MaterialVariant = p31.MaterialVariant;
            p32.CollisionGroup = p34;
            applyTextures(p31, p32);
        end;

        local function clearAppearance(p36) -- Line: 186
            for _, child in p36:GetChildren() do
                if child:IsA("Texture") or child:IsA("Decal") then
                    child:Destroy();
                end;
            end;

            p36.MaterialVariant = "";
        end;

        local function returnRock(p37) -- Line: 195
            -- upvalues: clearAppearance (copy), Folder (copy), u18 (copy)
            clearAppearance(p37);
            p37.Anchored = true;
            p37.CanCollide = false;
            p37.CollisionGroup = "Default";
            p37.Parent = Folder;
            u18:ReturnPart(p37);
        end;

        local function groundCast(p38, p39, p40) -- Line: 204
            return workspace:Raycast(p38, Vector3.new(0, -p39, 0), p40);
        end;

        local function spawnRock(p41, p42, p43, p44, p45, p46) -- Line: 208
            -- upvalues: u18 (copy), u17 (copy), applyTextures (copy)
            local v47 = u18:GetPart();
            v47.Size = p43;
            v47.CanCollide = p44;
            v47.CollisionGroup = p46;
            local v48 = CFrame.lookAt(p41.Position, p42);
            local Angles = CFrame.Angles;
            local v49 = math.random(-45, 45);
            v47.CFrame = v48 * Angles(0, 0, (math.rad(v49)));
            v47.Parent = p45;
            local Instance2 = p41.Instance;
            local v50 = u17[Instance2.Material];

            if v50 then
                v50(v47, p41, Instance2.Color, p46);

                return v47;
            end;

            v47.Material = Instance2.Material;
            v47.Color = Instance2.Color;
            v47.MaterialVariant = Instance2.MaterialVariant;
            v47.CollisionGroup = p46;
            applyTextures(Instance2, v47);

            return v47;
        end;

        local function tweenRockIn(p51, p52, p53) -- Line: 222
            -- upvalues: TweenService (copy)
            p51.CFrame = p51.CFrame - p51.CFrame.Position + p52 - Vector3.new(0, p51.Size.X * 2, 0);
            local v54 = TweenService:Create(p51, TweenInfo.new(p53, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, math.random(2, 10) / 100), {
                Position = p52
            });
            v54:Play();

            return v54;
        end;

        local function tweenRockOut(p55, p56) -- Line: 236
            -- upvalues: TweenService (copy)
            local v57 = p55.Position - Vector3.new(0, p55.Size.X * 2, 0);
            local v58 = TweenService:Create(p55, TweenInfo.new(p56, Enum.EasingStyle.Cubic, Enum.EasingDirection.In, 0, false, math.random(10, 50) / 100), {
                Position = v57
            });
            v58:Play();

            return v58;
        end;

        local function scheduleRockReturn(u59, u60, u61) -- Line: 250
            -- upvalues: tweenRockOut (copy), clearAppearance (copy), Folder (copy), u18 (copy)
            task.spawn(function() -- Line: 251
                -- upvalues: u60 (copy), tweenRockOut (ref), u59 (copy), u61 (copy), clearAppearance (ref), Folder (ref), u18 (ref)
                task.wait(u60);
                tweenRockOut(u59, u61).Completed:Wait();
                local v62 = u59;
                clearAppearance(v62);
                v62.Anchored = true;
                v62.CanCollide = false;
                v62.CollisionGroup = "Default";
                v62.Parent = Folder;
                u18:ReturnPart(v62);
            end);
        end;

        local function spawnAndAnimate(p63, p64, p65) -- Line: 259
            -- upvalues: spawnRock (copy), tweenRockIn (copy), tweenRockOut (copy), clearAppearance (copy), Folder (copy), u18 (copy)
            local v66 = p65.MaxRange / (p65.Frequency / 2);
            local v67 = v66 * (math.random(15, 40) / 10);
            local v68 = v66 * (math.random(15, 40) / 10);
            local u69 = spawnRock(p63, p64, Vector3.new(v67, v68, v66), p65.CanCollide, p65.Parent, p65.CollisionGroup);
            tweenRockIn(u69, u69.Position, p65.FadeIn);

            if p65.Duration then
                local Duration = p65.Duration;
                local FadeOut = p65.FadeOut;
                task.spawn(function() -- Line: 251
                    -- upvalues: Duration (copy), tweenRockOut (ref), u69 (copy), FadeOut (copy), clearAppearance (ref), Folder (ref), u18 (ref)
                    task.wait(Duration);
                    tweenRockOut(u69, FadeOut).Completed:Wait();
                    local v70 = u69;
                    clearAppearance(v70);
                    v70.Anchored = true;
                    v70.CanCollide = false;
                    v70.CollisionGroup = "Default";
                    v70.Parent = Folder;
                    u18:ReturnPart(v70);
                end);
            end;

            return u69;
        end;

        function v2.generate(p71) -- Line: 278
            -- upvalues: u3 (copy), buildRaycastParams (copy), spawnRock (copy), tweenRockIn (copy), tweenRockOut (copy), clearAppearance (copy), Folder (copy), u18 (copy)
            for i, v in pairs(u3) do
                if p71[i] == nil then
                    p71[i] = v;
                end;
            end;

            local Position = p71.Position;
            local LookAtPosition = p71.LookAtPosition;
            local MaxElevation = p71.MaxElevation;
            local MinRange = p71.MinRange;
            local MaxRange = p71.MaxRange;
            local Rings = p71.Rings;
            local Frequency = p71.Frequency;
            local CanCollide = p71.CanCollide;
            local FadeIn = p71.FadeIn;
            local FadeOut = p71.FadeOut;
            local Duration = p71.Duration;
            local Parent = p71.Parent;
            local CollisionGroup = p71.CollisionGroup;
            local v72 = buildRaycastParams(p71.Whitelist, p71.Blacklist);
            local v73 = (MaxRange - MinRange) / Rings;
            local v74 = Position + Vector3.new(0, MaxElevation, 0);
            local v75 = {};

            for i = 1, Frequency do
                local v76 = math.random(-math.abs(180 / Frequency), (math.abs(180 / Frequency)));
                local v77 = math.rad(v76);
                local v78 = CFrame.new(v74) * CFrame.Angles(0, v77, 0);

                for i2 = 1, Rings do
                    local v79 = Rings == 1 and MaxRange and MaxRange or MinRange + v73 * i2;
                    local v80 = v79 / (Frequency / 2);
                    local v81 = v80 * (math.random(15, 40) / 10);
                    local v82 = v80 * (math.random(15, 40) / 10);
                    local v83 = Vector3.new(v81, v82, v80);
                    local v84 = v78 * CFrame.Angles(0, math.rad(i * (360 / Frequency)), 0) * CFrame.new(0, 0, -v79);
                    local v85 = workspace:Raycast(v84.Position, Vector3.new(0, -MaxElevation - 500, 0), v72);

                    if v85 then
                        local v86 = spawnRock(v85, LookAtPosition, v83, CanCollide, Parent, CollisionGroup);
                        table.insert(v75, v86);
                    end;
                end;
            end;

            for _, v in v75 do
                tweenRockIn(v, v.Position, FadeIn);

                if Duration then
                    task.spawn(function() -- Line: 251
                        -- upvalues: Duration (copy), tweenRockOut (ref), v (copy), FadeOut (copy), clearAppearance (ref), Folder (ref), u18 (ref)
                        task.wait(Duration);
                        tweenRockOut(v, FadeOut).Completed:Wait();
                        local v87 = v;
                        clearAppearance(v87);
                        v87.Anchored = true;
                        v87.CanCollide = false;
                        v87.CollisionGroup = "Default";
                        v87.Parent = Folder;
                        u18:ReturnPart(v87);
                    end);
                end;
            end;

            return v75;
        end;

        function v2.rockTrail(p88, p89, p90) -- Line: 344
            -- upvalues: u3 (copy), buildRaycastParams (copy), spawnAndAnimate (copy)
            local v91 = p90 or {};

            for i, v in pairs(u3) do
                if v91[i] == nil then
                    v91[i] = v;
                end;
            end;

            local v92 = buildRaycastParams(v91.Whitelist, v91.Blacklist);
            local LookAtPosition = v91.LookAtPosition;
            local Position = (p88 + p88.RightVector * -p89).Position;
            local v93 = workspace:Raycast((p88 + p88.RightVector * p89).Position, Vector3.new(0, -500, 0), v92);
            local v94 = workspace:Raycast(Position, Vector3.new(0, -500, 0), v92);

            if v93 then
                spawnAndAnimate(v93, LookAtPosition, v91);
            end;

            if v94 then
                spawnAndAnimate(v94, LookAtPosition, v91);
            end;
        end;

        function v2.expandCache(p95) -- Line: 370
            -- upvalues: u18 (copy)
            u18:Expand(p95);
        end;

        p1.Cache["Sharm Rock Crater"] = v2.generate;
        p1.Cache["Sharm Rock Trail"] = v2.rockTrail;
    end
};