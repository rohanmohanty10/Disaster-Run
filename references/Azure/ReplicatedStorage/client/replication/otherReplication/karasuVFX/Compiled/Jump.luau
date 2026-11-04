 

 

return {
    { 5, function(p1, p2) -- Line: 3
            p1.Jump({
                Character = p2
            });
        end },
    { 40, function(p3, p4, p5) -- Line: 9
            local v6;

            if p4 then
                v6 = p4:FindFirstChild("HumanoidRootPart");
            else
                v6 = p4;
            end;

            if not v6 then
                return;
            end;

            local v7 = tick();
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            RaycastParams_new_ret.FilterDescendantsInstances = { workspace.map };

            repeat
                task.wait();
            until v6 and workspace:Raycast(v6.Position, Vector3.new(0, -3, 0), RaycastParams_new_ret) or tick() - v7 >= 3;

            if p4 then
                p3.Land({
                    Character = p4
                });
            end;

            if p5 then
                p5:Play();
            end;
        end }
};