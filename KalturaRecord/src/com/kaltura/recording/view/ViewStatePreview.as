package com.kaltura.recording.view
{

import flash.events.Event;
import flash.events.MouseEvent;
	

public class ViewStatePreview extends ViewState
{

	static private const MARGIN_BOTTOM:Number = 11;

	public var player:PreviewPlayer = new PreviewPlayer( Global.THEME.getSkinById( "previewPlayer" ));
	public var popupDialog:PopupDialog = new PopupDialog( Global.THEME.getSkinById( "popupDialog" ));


	public function ViewStatePreview()
	{
		addChild( player );
		addChild( popupDialog );
	}

	override protected function onAddedToStage( evt:Event=null ):void
	{
		popupDialog.addEventListener( MouseEvent.CLICK, onMouseClick, false, 0, true );
		popupDialog.message = Global.LOCALE.getString( "Dialog.Overwrite" );
		popupDialog.visible = false;

		player.addEventListener( MouseEvent.CLICK, onMouseClick, false, 0, true );
		player.buttonSave.label = Global.LOCALE.getString( "Button.Save" );
	}

	override public function open():void
	{
		super.open();
 		/*if( Global.VIEW_PARAMS.autoPreview )
		{
			player.play();
		} */
	}
	
	override public function close():void
	{
		//if( !player.stopped ) player.stop();
		super.close();
	}

	private function onMouseClick( evt:MouseEvent ):void
	{
		if( evt.target == player.buttonReRecord )
		{
			player.stop();
			player.mouseChildren = false;
			player.mouseEnabled = false;
			popupDialog.visible = true;		
		}
		
		if( evt.target == popupDialog.buttonYes || evt.target == popupDialog.buttonNo )
		{
			player.mouseChildren = true;
			player.mouseEnabled = true;
			popupDialog.visible = false;
		}
		
		if( evt.target == popupDialog.buttonYes )
		{
			dispatchEvent( new ViewEvent( ViewEvent.PREVIEW_RERECORD, true ));
		}
		
		if( evt.target == player.buttonSave )
		{
			player.stop();
			dispatchEvent( new ViewEvent( ViewEvent.PREVIEW_SAVE, true ));
		}
	}

	override protected function onResize():void
	{
		player.x = Math.round( this.width/2 );
		player.y = Math.round( this.height - player.height/2 - MARGIN_BOTTOM );
		
		popupDialog.x = Math.round( this.width/2 );
		popupDialog.y = Math.round( this.height/2 );
	}

	
}
}