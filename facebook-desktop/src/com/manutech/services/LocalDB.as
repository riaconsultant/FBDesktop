package com.manutech.services
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.filesystem.File;

	public class LocalDB
	{
		public var sqlConn:SQLConnection;
		public var sqlStmt:SQLStatement;
		
		public function LocalDB()
		{
			
		}
		
		public function create_db(arg:String):SQLConnection{
			sqlConn=new SQLConnection();
			var file:File=File.applicationDirectory.resolvePath(arg+'.db');
			if(!file.exists){
				sqlConn.open(file,'create');
			}else{
				sqlConn.open(file,'update');
			}
			return sqlConn;
		}
		
		private function createTable(sql:String):Boolean{
			var stmt:SQLStatement=new SQLStatement();
			stmt.sqlConnection=sqlConn;
			stmt.text=sql;
			stmt.execute();
			return true;
		}
		
		private function fetch_data():void{
			sqlStmt=new SQLStatement();
			if(sqlConn.connected){
				sqlStmt.sqlConnection=sqlConn;
			}else{
				//create_db();
			}
			sqlStmt.text="select * from Setting";
			sqlStmt.execute();
		}
		private function insert_data():void{
			sqlStmt=new SQLStatement();
			//is_Connect();
			sqlStmt.sqlConnection=sqlConn;
			sqlStmt.text="select * from friend";
			sqlStmt.execute();
		}
		private function update_data():void{
			
		}
		
		private function is_Connect():SQLStatement{
			sqlStmt=new SQLStatement();
			if(!sqlConn.connected){
				//create_db();
			}
			is_Connect();
			sqlStmt.sqlConnection=sqlConn;
			sqlStmt.text="select * from Setting";
			sqlStmt.execute();
			return sqlStmt;
		}
	}
}