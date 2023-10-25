dofile_once("data/scripts/lib/utilities.lua") 
  
 local entity = GetUpdatedEntityID() 
  
 local root = EntityGetRootEntity( entity ) 
  
 local x, y = EntityGetTransform(root) 
 local max_hp = 0         
 local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" ) 
  
 max_hp = ComponentGetValue2( damagemodel, "max_hp" ) 

EntityInflictDamage( root, max_hp / 200 , "DAMAGE_MELEE", "Consumed", "PLAYER_RAGDOLL_CAMERA", 0, 0) 
EntityInflictDamage( root, max_hp / 200 , "DAMAGE_PROJECTILE", "Consumed", "PLAYER_RAGDOLL_CAMERA", 0, 0) 