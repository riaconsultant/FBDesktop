package data
{	
	[Bindable]
	public class VideoVO
	{
		/**
		 * Custom, bindable Video class
		 * The properties of the base yourtubelib Video class are
		 * not bindable. The TileList's drop in ItemRenderer requires
		 * the properties are bindable. All properties of the 
		 * 
		 */
		public var author:String;
		public var title:String;
		public var lengthSeconds:uint;
		public var ratingAvg:Number;
		public var ratingCount:uint;
		public var description:String;
		public var viewCount:uint;
		public var commentCount:uint;
		public var tags:String;
		public var url:String;
		public var thumbnailUrl:String;
		public var playerURL:String;
	}
}