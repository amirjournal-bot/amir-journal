const{app,BrowserWindow,Menu}=require('electron');
app.whenReady().then(()=>{Menu.setApplicationMenu(null);const w=new BrowserWindow({width:1100,height:800,title:'امیر ژورنال'});w.loadFile('index.html');w.webContents.openDevTools({mode:'detach'})});
app.on('window-all-closed',()=>app.quit());
