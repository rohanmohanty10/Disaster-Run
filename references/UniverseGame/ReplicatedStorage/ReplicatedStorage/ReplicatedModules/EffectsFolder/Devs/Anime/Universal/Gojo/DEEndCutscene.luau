  

 

return function(u1, p2, p3) -- Line: 2
    game.StarterGui:SetCore("ResetButtonCallback", false);
    u1.HumanoidRootPart.VoidGrab:Play();
    task.delay(1.6, function() -- Line: 6
        -- upvalues: u1 (copy)
        u1.HumanoidRootPart.VoidVL:Play();
    end);
    local u4 = {};

    for _, child in ipairs(playerGui:GetChildren()) do
        if child:IsA("ScreenGui") and child.Enabled then
            table.insert(u4, child);
            child.Enabled = false;
        end;
    end;

    EffectsTable.AttachCamera(p3:WaitForChild("Camera"));
    tempStates.DEGrabCam = {
        [workspace.CurrentCamera] = {
            FieldOfView = workspace.CurrentCamera.FieldOfView
        }
    };

    function cancelCutscene()
        -- upvalues: u4 (copy)
        revertState("DEGrabLighting");
        revertState("FunnyHeadRip");
        revertState("DEGrabCam");

        for _, v in ipairs(u4) do
            v.Enabled = true;
        end;
    end;
end;