
import com.TO.Product;

import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.ObjectUtil;

public var product:Product=new Product();

public function getCategoryListner(evt:ResultEvent):void{
	
	this.productDetail(evt.result[0].children,evt.result[1]);
	
	//productArr=evt.result[1] as Array;
}
public function getProductListner(evt:ResultEvent):void{
	var productArr:Array=evt.result as Array;
	//this.productDetail(evt.result.children);
	product.id=productArr[0]['product_id'];
	product.name=productArr[0]['name'];
	product.sku=productArr[0]['sku'];
	product.weight=productArr[0]['weight'];
	product.price=productArr[0]['price'];
	product.description=productArr[0]['description'];
	product.imgArr=productArr[1];
	product.selectName=product.name;
	mainProductImage.source=productArr[1][0]['url'];
	if(productArr[1].length > 1){
		productImageList.dataProvider=productArr[1];
	}else{
		productImageList.visible=false;
	}
}