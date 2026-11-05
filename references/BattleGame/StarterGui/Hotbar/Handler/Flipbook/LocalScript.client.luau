local XOffset = 4
local YOffset = 4

script.Parent.ImageRectSize = Vector2.new(204.8, 204.8)

shared.loop(function()
	XOffset -= 1

	if XOffset <= -1 then
		YOffset -= 1
		XOffset = 4

		if YOffset <= -1 then
			YOffset = 4
		end
	end


	script.Parent.ImageRectOffset = Vector2.new(204.8 * XOffset, 204.8 * YOffset)
end, 24)