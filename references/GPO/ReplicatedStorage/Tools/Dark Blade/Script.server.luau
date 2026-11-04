 

if not script:GetAttribute("Played") then
    script:SetAttribute("Played", true)
    script.Parent:WaitForChild("AnimationController"):LoadAnimation(script:WaitForChild("Animation")):Play()
end