-- a nice dirt road for small villages or paths to fields
minetest.register_node("feldweg:feldweg", {
	description = ("dirt road"),
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
	tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "feldweg.obj",
})

minetest.register_node("feldweg:feldweg_crossing", {
	description = ("dirt road crossing"),
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
	tiles = {"feldweg_feldweg_end.png","default_dirt.png",
			"default_grass.png","feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "feldweg-crossing.obj",
})
	                                          
minetest.register_node("feldweg:feldweg_t_junction", {
	description = ("dirt road t junction"),
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
	tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png", "default_dirt.png",
			"default_grass.png","feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "feldweg-T-junction.obj",
})
	                                          
minetest.register_node("feldweg:feldweg_curve", {
	description = ("dirt road curve"),
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
	tiles = {"default_dirt.png^default_grass_side.png","default_grass.png",
			"default_dirt.png^default_grass_side.png","feldweg_feldweg_surface.png",
			"default_dirt.png","feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "feldweg-curve.obj",
})
							
minetest.register_node("feldweg:feldweg_end", {
	description = ("dirt road end"),
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
	tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png",
			"feldweg_feldweg_surface.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "feldweg_end.obj",
})
	   
local box_slope = {
	type = "fixed",
	fixed = {
			{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
			{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
			{-0.5,     0,     0, 0.5,  0.25, 0.5},
			{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
}};
 
local box_slope_long = {
	type = "fixed",
	fixed = {
			{-0.5,  -0.5,  -1.5, 0.5, -0.10, 0.5},
			{-0.5, -0.25,  -1.3, 0.5, -0.25, 0.5},
			{-0.5, -0.25,  -1.0, 0.5,     0, 0.5},
			{-0.5,     0,  -0.5, 0.5,  0.25, 0.5},
			{-0.5,  0.25,     0, 0.5,   0.5, 0.5}
}};
 
minetest.register_node("feldweg:feldweg_slope", {
	description = ("dirt road slope"),
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
	tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "feldweg_slope.obj",
 
	collision_box = box_slope,
	selection_box = box_slope,
})
											   
minetest.register_node("feldweg:feldweg_slope_long", {
	description = ("dirt road slope long"),
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
	tiles = {"feldweg_feldweg_end.png","default_dirt.png^default_grass_side.png",
			"default_dirt.png", "default_grass.png",
			"feldweg_feldweg_surface.png",
			"feldweg_feldweg_surface.png^feldweg_feldweg_edges.png"},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "feldweg_slope_long.obj",
	collision_box = box_slope_long,
	selection_box = box_slope_long,
})
											   
minetest.register_craft({
	output = "feldweg:feldweg_slope 3",
	recipe = {
			{"feldweg:feldweg", "", "" },
			{"feldweg:feldweg", "feldweg:feldweg", ""}
	},
})	     
											   
minetest.register_craft({
	output = "feldweg:feldweg_slope_long 4",
	recipe = {
			 {"feldweg:feldweg", "", "" },
			 {"feldweg:feldweg", "feldweg:feldweg", "feldweg:feldweg"}
	},
})

print("[MOD] feldweg loaded!")