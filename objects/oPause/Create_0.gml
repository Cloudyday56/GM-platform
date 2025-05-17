pause = false;

layerName = "PauseLayer";

function update_pause()
{
	if pause
	{
		instance_deactivate_all(true);
		layer_set_visible(layerName, true);
	}
	else
	{
		instance_activate_all();
		layer_set_visible(layerName, false);
	}

}



