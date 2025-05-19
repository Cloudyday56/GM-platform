reset = false;

layerName = "ResetLayer";

function update_reset()
{
	if reset
	{
		layer_set_visible(layerName, true);
	}
	else
	{
		layer_set_visible(layerName, false);
	}

}



