package com.container.objecthandles
{

	public interface IChildManager
	{
		function addChild( container:Object, child:Object ) : void;
		function removeChild( container:Object, child:Object ) : void;
	}
}