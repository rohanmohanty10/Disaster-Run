 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local Streamable = require(script.Parent.Streamable)

	local instanceFolder
	local instanceModel

	local function CreateInstance(name)
		local folder = Instance.new("Folder")
		folder.Name = name
		folder.Archivable = false
		folder.Parent = instanceFolder
		return folder
	end

	local function CreatePrimary()
		local primary = Instance.new("Part")
		primary.Anchored = true
		primary.Parent = instanceModel
		instanceModel.PrimaryPart = primary
		return primary
	end

	beforeAll(function()
		instanceFolder = Instance.new("Folder")
		instanceFolder.Name = "KnitTestFolder"
		instanceFolder.Archivable = false
		instanceFolder.Parent = workspace
		instanceModel = Instance.new("Model")
		instanceModel.Name = "KnitTestModel"
		instanceModel.Archivable = false
		instanceModel.Parent = workspace
	end)

	afterEach(function()
		instanceFolder:ClearAllChildren()
		instanceModel:ClearAllChildren()
	end)

	afterAll(function()
		instanceFolder:Destroy()
		instanceModel:Destroy()
	end)

	describe("Streamable", function()
		it("should detect instance that is immediately available", function()
			local testInstance = CreateInstance("TestImmediate")
			local streamable = Streamable.new(instanceFolder, "TestImmediate")
			local observed = 0
			local cleaned = 0
			streamable:Observe(function(_instance, trove)
				observed += 1
				trove:Add(function()
					cleaned += 1
				end)
			end)
			task.wait()
			testInstance.Parent = nil
			task.wait()
			testInstance.Parent = instanceFolder
			task.wait()
			streamable:Destroy()
			task.wait()
			expect(observed).to.equal(2)
			expect(cleaned).to.equal(2)
		end)

		it("should detect instance that is not immediately available", function()
			local streamable = Streamable.new(instanceFolder, "TestImmediate")
			local observed = 0
			local cleaned = 0
			streamable:Observe(function(_instance, trove)
				observed += 1
				trove:Add(function()
					cleaned += 1
				end)
			end)
			task.wait(0.1)
			local testInstance = CreateInstance("TestImmediate")
			task.wait()
			testInstance.Parent = nil
			task.wait()
			testInstance.Parent = instanceFolder
			task.wait()
			streamable:Destroy()
			task.wait()
			expect(observed).to.equal(2)
			expect(cleaned).to.equal(2)
		end)

		it("should detect primary part that is immediately available", function()
			local testInstance = CreatePrimary()
			local streamable = Streamable.primary(instanceModel)
			local observed = 0
			local cleaned = 0
			streamable:Observe(function(_instance, trove)
				observed += 1
				trove:Add(function()
					cleaned += 1
				end)
			end)
			task.wait()
			testInstance.Parent = nil
			task.wait()
			testInstance.Parent = instanceModel
			instanceModel.PrimaryPart = testInstance
			task.wait()
			streamable:Destroy()
			task.wait()
			expect(observed).to.equal(2)
			expect(cleaned).to.equal(2)
		end)

		it("should detect primary part that is not immediately available", function()
			local streamable = Streamable.primary(instanceModel)
			local observed = 0
			local cleaned = 0
			streamable:Observe(function(_instance, trove)
				observed += 1
				trove:Add(function()
					cleaned += 1
				end)
			end)
			task.wait(0.1)
			local testInstance = CreatePrimary()
			task.wait()
			testInstance.Parent = nil
			task.wait()
			testInstance.Parent = instanceModel
			instanceModel.PrimaryPart = testInstance
			task.wait()
			streamable:Destroy()
			task.wait()
			expect(observed).to.equal(2)
			expect(cleaned).to.equal(2)
		end)
	end)
end

]]

 

return function() -- Line: 1
    local Streamable = require(script.Parent.Streamable);
    local u1 = nil;
    local u2 = nil;

    local function CreateInstance(p3) -- Line: 7
        -- upvalues: u1 (ref)
        local Folder = Instance.new("Folder");
        Folder.Name = p3;
        Folder.Archivable = false;
        Folder.Parent = u1;

        return Folder;
    end;

    local function CreatePrimary() -- Line: 15
        -- upvalues: u2 (ref)
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.Parent = u2;
        u2.PrimaryPart = Part;

        return Part;
    end;

    beforeAll(function() -- Line: 23
        -- upvalues: u1 (ref), u2 (ref)
        u1 = Instance.new("Folder");
        u1.Name = "KnitTestFolder";
        u1.Archivable = false;
        u1.Parent = workspace;
        u2 = Instance.new("Model");
        u2.Name = "KnitTestModel";
        u2.Archivable = false;
        u2.Parent = workspace;
    end);
    afterEach(function() -- Line: 34
        -- upvalues: u1 (ref), u2 (ref)
        u1:ClearAllChildren();
        u2:ClearAllChildren();
    end);
    afterAll(function() -- Line: 39
        -- upvalues: u1 (ref), u2 (ref)
        u1:Destroy();
        u2:Destroy();
    end);
    describe("Streamable", function() -- Line: 44
        -- upvalues: u1 (ref), Streamable (copy), u2 (ref)
        it("should detect instance that is immediately available", function() -- Line: 45
            -- upvalues: u1 (ref), Streamable (ref)
            local Folder = Instance.new("Folder");
            Folder.Name = "TestImmediate";
            Folder.Archivable = false;
            Folder.Parent = u1;
            local v4 = Streamable.new(u1, "TestImmediate");
            local u5 = 0;
            local u6 = 0;
            v4:Observe(function(p7, p8) -- Line: 50
                -- upvalues: u5 (ref), u6 (ref)
                u5 = u5 + 1;
                p8:Add(function() -- Line: 52
                    -- upvalues: u6 (ref)
                    u6 = u6 + 1;
                end);
            end);
            task.wait();
            Folder.Parent = nil;
            task.wait();
            Folder.Parent = u1;
            task.wait();
            v4:Destroy();
            task.wait();
            expect(u5).to.equal(2);
            expect(u6).to.equal(2);
        end);
        it("should detect instance that is not immediately available", function() -- Line: 67
            -- upvalues: Streamable (ref), u1 (ref)
            local v9 = Streamable.new(u1, "TestImmediate");
            local u10 = 0;
            local u11 = 0;
            v9:Observe(function(p12, p13) -- Line: 71
                -- upvalues: u10 (ref), u11 (ref)
                u10 = u10 + 1;
                p13:Add(function() -- Line: 73
                    -- upvalues: u11 (ref)
                    u11 = u11 + 1;
                end);
            end);
            task.wait(0.1);
            local Folder = Instance.new("Folder");
            Folder.Name = "TestImmediate";
            Folder.Archivable = false;
            Folder.Parent = u1;
            task.wait();
            Folder.Parent = nil;
            task.wait();
            Folder.Parent = u1;
            task.wait();
            v9:Destroy();
            task.wait();
            expect(u10).to.equal(2);
            expect(u11).to.equal(2);
        end);
        it("should detect primary part that is immediately available", function() -- Line: 90
            -- upvalues: u2 (ref), Streamable (ref)
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.Parent = u2;
            u2.PrimaryPart = Part;
            local v14 = Streamable.primary(u2);
            local u15 = 0;
            local u16 = 0;
            v14:Observe(function(p17, p18) -- Line: 95
                -- upvalues: u15 (ref), u16 (ref)
                u15 = u15 + 1;
                p18:Add(function() -- Line: 97
                    -- upvalues: u16 (ref)
                    u16 = u16 + 1;
                end);
            end);
            task.wait();
            Part.Parent = nil;
            task.wait();
            Part.Parent = u2;
            u2.PrimaryPart = Part;
            task.wait();
            v14:Destroy();
            task.wait();
            expect(u15).to.equal(2);
            expect(u16).to.equal(2);
        end);
        it("should detect primary part that is not immediately available", function() -- Line: 113
            -- upvalues: Streamable (ref), u2 (ref)
            local v19 = Streamable.primary(u2);
            local u20 = 0;
            local u21 = 0;
            v19:Observe(function(p22, p23) -- Line: 117
                -- upvalues: u20 (ref), u21 (ref)
                u20 = u20 + 1;
                p23:Add(function() -- Line: 119
                    -- upvalues: u21 (ref)
                    u21 = u21 + 1;
                end);
            end);
            task.wait(0.1);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.Parent = u2;
            u2.PrimaryPart = Part;
            task.wait();
            Part.Parent = nil;
            task.wait();
            Part.Parent = u2;
            u2.PrimaryPart = Part;
            task.wait();
            v19:Destroy();
            task.wait();
            expect(u20).to.equal(2);
            expect(u21).to.equal(2);
        end);
    end);
end;