
import com.components.ProductCategoryCanvas;


public function productDetail(categoryArr:Array,arg:Array):void{
	for(var i:int=0;i<categoryArr.length;i++){
		if(categoryArr[i]['is_active']=='1'){
			var subArr:Array=categoryArr[i].children;
			for(var j:int=0;j<subArr.length;j++){
				if(subArr[j]['is_active']=='1'){
					catAccord.addChild(this.customProductDisplay(subArr[j],arg));
				}
			}
		}
	}
}

public function customProductDisplay(arg:Object,arg1:Array):ProductCategoryCanvas{
	var preCanvas:ProductCategoryCanvas=new ProductCategoryCanvas();
	preCanvas.label=arg['name'];
	preCanvas.id=arg['parent_id'];
	//var flag:Boolean=false;
	var productListArray:Array=new Array();
	for(var i:int=0;i<arg1.length;i++){
		//trace(arg1[i]['category_ids'][0] + "---"+arg['category_id']);
		if(arg1[i]['category_ids'][0]== arg['category_id']){
			var productListObj:Object=new Object();
			productListObj['id']=arg1[i]['product_id'];
			productListObj['name']=arg1[i]['name'];
			productListObj['sku']=arg1[i]['sku'];
			productListArray.push(productListObj);
			//if(flag==false){
				//myObj.getProductInfo(productListObj.id,productListObj.sku);
				//preCanvas.myList.selectedItem=productListObj;
				//flag=true;
			//}
		}
	}
	preCanvas.myData=productListArray;
	return preCanvas;
}

public function applyImage(arg:Object):void{
	mainProductImage.source=arg.url;
}


