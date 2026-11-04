 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local Trove = require(script.Parent)

	describe("Trove", function()
		local trove

		beforeEach(function()
			trove = Trove.new()
		end)

		afterEach(function()
			if trove then
				trove:Destroy()
				trove = nil
			end
		end)

		it("should add and clean up roblox instance", function()
			local part = Instance.new("Part")
			part.Parent = workspace
			trove:Add(part)
			trove:Destroy()
			expect(part.Parent).to.equal(nil)
		end)

		it("should add and clean up roblox connection", function()
			local connection = workspace.Changed:Connect(function() end)
			trove:Add(connection)
			trove:Destroy()
			expect(connection.Connected).to.equal(false)
		end)

		it("should add and clean up a table with a destroy method", function()
			local tbl = { Destroyed = false }
			function tbl:Destroy()
				self.Destroyed = true
			end
			trove:Add(tbl)
			trove:Destroy()
			expect(tbl.Destroyed).to.equal(true)
		end)

		it("should add and clean up a table with a disconnect method", function()
			local tbl = { Connected = true }
			function tbl:Disconnect()
				self.Connected = false
			end
			trove:Add(tbl)
			trove:Destroy()
			expect(tbl.Connected).to.equal(false)
		end)

		it("should add and clean up a function", function()
			local fired = false
			trove:Add(function()
				fired = true
			end)
			trove:Destroy()
			expect(fired).to.equal(true)
		end)

		it("should allow a custom cleanup method", function()
			local tbl = { Cleaned = false }
			function tbl:Cleanup()
				self.Cleaned = true
			end
			trove:Add(tbl, "Cleanup")
			trove:Destroy()
			expect(tbl.Cleaned).to.equal(true)
		end)

		it("should return the object passed to add", function()
			local part = Instance.new("Part")
			local part2 = trove:Add(part)
			expect(part).to.equal(part2)
			trove:Destroy()
		end)

		it("should fail to add object without proper cleanup method", function()
			local tbl = {}
			expect(function()
				trove:Add(tbl)
			end).to.throw()
		end)

		it("should construct an object and add it", function()
			local class = {}
			class.__index = class
			function class.new(msg)
				local self = setmetatable({}, class)
				self._msg = msg
				self._destroyed = false
				return self
			end
			function class:Destroy()
				self._destroyed = true
			end
			local msg = "abc"
			local obj = trove:Construct(class, msg)
			expect(typeof(obj)).to.equal("table")
			expect(getmetatable(obj)).to.equal(class)
			expect(obj._msg).to.equal(msg)
			expect(obj._destroyed).to.equal(false)
			trove:Destroy()
			expect(obj._destroyed).to.equal(true)
		end)

		it("should connect to a signal", function()
			local connection = trove:Connect(workspace.Changed, function() end)
			expect(typeof(connection)).to.equal("RBXScriptConnection")
			expect(connection.Connected).to.equal(true)
			trove:Destroy()
			expect(connection.Connected).to.equal(false)
		end)

		it("should remove an object", function()
			local connection = trove:Connect(workspace.Changed, function() end)
			expect(trove:Remove(connection)).to.equal(true)
			expect(connection.Connected).to.equal(false)
		end)

		it("should not remove an object not in the trove", function()
			local connection = workspace.Changed:Connect(function() end)
			expect(trove:Remove(connection)).to.equal(false)
			expect(connection.Connected).to.equal(true)
			connection:Disconnect()
		end)

		it("should attach to instance", function()
			local part = Instance.new("Part")
			part.Parent = workspace
			local connection = trove:AttachToInstance(part)
			expect(connection.Connected).to.equal(true)
			part:Destroy()
			expect(connection.Connected).to.equal(false)
		end)

		it("should fail to attach to instance not in hierarchy", function()
			local part = Instance.new("Part")
			expect(function()
				trove:AttachToInstance(part)
			end).to.throw()
		end)

		it("should extend itself", function()
			local subTrove = trove:Extend()
			local called = false
			subTrove:Add(function()
				called = true
			end)
			expect(subTrove).to.be.a("table")
			expect(getmetatable(subTrove)).to.equal(Trove)
			trove:Clean()
			expect(called).to.equal(true)
		end)

		it("should clone an instance", function()
			local name = "TroveCloneTest"
			local p1 = trove:Construct(Instance.new, "Part")
			p1.Name = name
			local p2 = trove:Clone(p1)
			expect(typeof(p2)).to.equal("Instance")
			expect(p2).to.never.equal(p1)
			expect(p2.Name).to.equal(name)
			expect(p1.Name).to.equal(p2.Name)
		end)

		it("should clean up a thread", function()
			local co = coroutine.create(function() end)
			trove:Add(co)
			expect(coroutine.status(co)).to.equal("suspended")
			trove:Clean()
			expect(coroutine.status(co)).to.equal("dead")
		end)
	end)
end

]]

 

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    describe("Trove", function() -- Line: 4
        -- upvalues: script_Parent (copy)
        local u1 = nil;
        beforeEach(function() -- Line: 7
            -- upvalues: u1 (ref), script_Parent (ref)
            u1 = script_Parent.new();
        end);
        afterEach(function() -- Line: 11
            -- upvalues: u1 (ref)
            if u1 then
                u1:Destroy();
                u1 = nil;
            end;
        end);
        it("should add and clean up roblox instance", function() -- Line: 18
            -- upvalues: u1 (ref)
            local Part = Instance.new("Part");
            Part.Parent = workspace;
            u1:Add(Part);
            u1:Destroy();
            expect(Part.Parent).to.equal(nil);
        end);
        it("should add and clean up roblox connection", function() -- Line: 26
            -- upvalues: u1 (ref)
            local v2 = workspace.Changed:Connect(function() -- Line: 27
            end);
            u1:Add(v2);
            u1:Destroy();
            expect(v2.Connected).to.equal(false);
        end);
        it("should add and clean up a table with a destroy method", function() -- Line: 33
            -- upvalues: u1 (ref)
            local v4 = {
                Destroyed = false,

                Destroy = function(p3) -- Line: 35, Name: Destroy
                    p3.Destroyed = true;
                end
            };
            u1:Add(v4);
            u1:Destroy();
            expect(v4.Destroyed).to.equal(true);
        end);
        it("should add and clean up a table with a disconnect method", function() -- Line: 43
            -- upvalues: u1 (ref)
            local v6 = {
                Connected = true,

                Disconnect = function(p5) -- Line: 45, Name: Disconnect
                    p5.Connected = false;
                end
            };
            u1:Add(v6);
            u1:Destroy();
            expect(v6.Connected).to.equal(false);
        end);
        it("should add and clean up a function", function() -- Line: 53
            -- upvalues: u1 (ref)
            local u7 = false;
            u1:Add(function() -- Line: 55
                -- upvalues: u7 (ref)
                u7 = true;
            end);
            u1:Destroy();
            expect(u7).to.equal(true);
        end);
        it("should allow a custom cleanup method", function() -- Line: 62
            -- upvalues: u1 (ref)
            local v9 = {
                Cleaned = false,

                Cleanup = function(p8) -- Line: 64, Name: Cleanup
                    p8.Cleaned = true;
                end
            };
            u1:Add(v9, "Cleanup");
            u1:Destroy();
            expect(v9.Cleaned).to.equal(true);
        end);
        it("should return the object passed to add", function() -- Line: 72
            -- upvalues: u1 (ref)
            local Part = Instance.new("Part");
            local v10 = u1:Add(Part);
            expect(Part).to.equal(v10);
            u1:Destroy();
        end);
        it("should fail to add object without proper cleanup method", function() -- Line: 79
            -- upvalues: u1 (ref)
            local u11 = {};
            expect(function() -- Line: 81
                -- upvalues: u1 (ref), u11 (copy)
                u1:Add(u11);
            end).to.throw();
        end);
        it("should construct an object and add it", function() -- Line: 86
            -- upvalues: u1 (ref)
            local u12 = {};
            u12.__index = u12;

            function u12.new(p13) -- Line: 89
                -- upvalues: u12 (copy)
                local v14 = setmetatable({}, u12);
                v14._msg = p13;
                v14._destroyed = false;

                return v14;
            end;

            function u12.Destroy(p15) -- Line: 95
                p15._destroyed = true;
            end;

            local v16 = u1:Construct(u12, "abc");
            expect((typeof(v16))).to.equal("table");
            expect((getmetatable(v16))).to.equal(u12);
            expect(v16._msg).to.equal("abc");
            expect(v16._destroyed).to.equal(false);
            u1:Destroy();
            expect(v16._destroyed).to.equal(true);
        end);
        it("should connect to a signal", function() -- Line: 108
            -- upvalues: u1 (ref)
            local v17 = u1:Connect(workspace.Changed, function() -- Line: 109
            end);
            expect((typeof(v17))).to.equal("RBXScriptConnection");
            expect(v17.Connected).to.equal(true);
            u1:Destroy();
            expect(v17.Connected).to.equal(false);
        end);
        it("should remove an object", function() -- Line: 116
            -- upvalues: u1 (ref)
            local v18 = u1:Connect(workspace.Changed, function() -- Line: 117
            end);
            expect(u1:Remove(v18)).to.equal(true);
            expect(v18.Connected).to.equal(false);
        end);
        it("should not remove an object not in the trove", function() -- Line: 122
            -- upvalues: u1 (ref)
            local v19 = workspace.Changed:Connect(function() -- Line: 123
            end);
            expect(u1:Remove(v19)).to.equal(false);
            expect(v19.Connected).to.equal(true);
            v19:Disconnect();
        end);
        it("should attach to instance", function() -- Line: 129
            -- upvalues: u1 (ref)
            local Part = Instance.new("Part");
            Part.Parent = workspace;
            local v20 = u1:AttachToInstance(Part);
            expect(v20.Connected).to.equal(true);
            Part:Destroy();
            expect(v20.Connected).to.equal(false);
        end);
        it("should fail to attach to instance not in hierarchy", function() -- Line: 138
            -- upvalues: u1 (ref)
            local Part = Instance.new("Part");
            expect(function() -- Line: 140
                -- upvalues: u1 (ref), Part (copy)
                u1:AttachToInstance(Part);
            end).to.throw();
        end);
        it("should extend itself", function() -- Line: 145
            -- upvalues: u1 (ref), script_Parent (ref)
            local v21 = u1:Extend();
            local u22 = false;
            v21:Add(function() -- Line: 148
                -- upvalues: u22 (ref)
                u22 = true;
            end);
            expect(v21).to.be.a("table");
            expect((getmetatable(v21))).to.equal(script_Parent);
            u1:Clean();
            expect(u22).to.equal(true);
        end);
        it("should clone an instance", function() -- Line: 157
            -- upvalues: u1 (ref)
            local v23 = u1:Construct(Instance.new, "Part");
            v23.Name = "TroveCloneTest";
            local v24 = u1:Clone(v23);
            expect((typeof(v24))).to.equal("Instance");
            expect(v24).to.never.equal(v23);
            expect(v24.Name).to.equal("TroveCloneTest");
            expect(v23.Name).to.equal(v24.Name);
        end);
        it("should clean up a thread", function() -- Line: 168
            -- upvalues: u1 (ref)
            local coroutine_create_ret = coroutine.create(function() -- Line: 169
            end);
            u1:Add(coroutine_create_ret);
            expect(coroutine.status(coroutine_create_ret)).to.equal("suspended");
            u1:Clean();
            expect(coroutine.status(coroutine_create_ret)).to.equal("dead");
        end);
    end);
end;