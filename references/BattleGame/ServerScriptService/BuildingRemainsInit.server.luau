-- Start before clients announce Debree.Ready, so first-hit remnants are visible.
require(game:GetService("ServerStorage"):WaitForChild("SBGModules"):WaitForChild("DebreeService")).Start()
