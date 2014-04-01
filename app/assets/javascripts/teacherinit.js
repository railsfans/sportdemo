Ext.onReady(function() {

	Ext.regModel("TreeInfo", {
    	fields: ['name', 'id', 'type']
    });
	var myStore = new Ext.data.TreeStore({
		model : 'TreeInfo',
		nodeParam : 'name', 
		proxy: {
            type: 'ajax',
            url: 'gettreenode.json',
            reader: 'json'
        },
		autoLoad: true,
        root: {
            name: 'expand',
			
            expanded: true,
        }
	});

	function alertMsg(record)
	{
        Ext.Ajax.request({
            url: 'getallclass.js',
            success: function(response){
                eval(response.responseText)
            },
            failure: function(response){
                
            },
            params: { id : record }
        });
	};
    
	var tree_panel = Ext.create('Ext.tree.Panel', {
	    listeners: {
		    'itemclick': function( grid, record, item, index, e, eOpts) {
		        if(record.get('type')=='class' ){
		     //   	alertMsg(record.get('id'));
					console.log("load class");
		      }
		    },
			itemmouseenter: function (view, rec) {
    			// console.log(rec.data.name);
			}
	    },
	    renderTo: 'historydata-management',
		layout: 'fit',
		tools:[{
			type:'refresh',
			tooltip: '刷新当前',
			handler: function(event, toolEl, panel){
				myStore.load()
			}
		},
		{
		    type:'help',
		 	hidden:true,
		    tooltip: 'Get Help',
		    handler: function(event, toolEl, panel){
		        // show help here
		    }
		}
		],
	    columns: [{
  	      	xtype: 'treecolumn', 
	        text: '年级列表',
	        dataIndex: 'name',
	    //    width: 150,
			flex: 3,
	        sortable: true
	    }],
	    store : myStore,
	    rootVisible: true,
	    border: false,
        autoScroll : true,
        containerScroll: true,
        bodyBorder: false,
        frame: false,
	}); 

        Ext.create('Ext.container.Viewport', {
            layout: 'border',
            items: [{
                region: 'north',
                border: false,
                height: 24,
                tbar: [{
                    	text: '<marquee width="400px">欢迎</marquee>',
                },  '->',
				{
                    text: '选项',
                    iconCls: 'options_icon',
                    menu: [{
                        text: 'User Info'
                    }, {
                        text: 'Settings'
                    }, {
                        text: 'Switch Theme'
                    }]
                }, '-', {
                    text: '退出',
                    iconCls: 'logout',
                    handler : function ( b, e ) {
                      	Ext.Msg.confirm("", "确定退出?", function(e){if(e == 'yes'){
						 	Ext.Ajax.request({
                   			url: "http://"+document.location.href.split('/')[2]+'/logout',
                   			success: function(response, opts) {
                       			window.location.href="http://"+document.location.href.split('/')[2]+'/login'
		                   },
		                   failure: function(response, opts) {
		                      console.log('server-side failure with status code ' + response.status);
		                   }
                			});
						}
						});
                  /*
                     Ext.MessageBox.show({
						    title:'Messagebox Title',
						    msg: 'Are you sure logout?',
						    buttonText: {yes: "Yes",no: "No"},
						    fn: function(btn){
                                Ext.Ajax.request({
                   					url: 'http://localhost:3000/logout',
                   					success: function(response, opts) {
                       					window.location.href="http://localhost:3000"
		                   			},
		                   			failure: function(response, opts) {
		                      			console.log('server-side failure with status code ' + response.status);
		                   			}
                					});
						        console.debug('you clicked: ',btn); //you clicked:  yes
						    }
						});
                  */
                     }
                }]
            }, {
                region: 'west',
                collapsible: true,
                split: true,
                id: 'left',
                title: '目录',
                width: 150,
                layout: 'accordion',
                items: [{
                    contentEl: 'historydata-management',
                    title:  '班级管理',
                    iconCls: 'first', // see the HEAD section for style used
                    autoScroll: true
                }, {
                    contentEl: 'personinfo-management',
                    title: '学期管理',
                    iconCls: 'second',
                    autoScroll: true
                }, {
                    contentEl: 'teacher-classcal',
                    title: '班级统计',
                    iconCls: 'second',
                    autoScroll: true
                }, {
                    contentEl: 'feedback-management',
                    title: '个人管理',
                    iconCls: 'five',
                    autoScroll: true
                }
                ],
                // could use a TreePanel or AccordionLayout for navigational items
            }, {
                region: 'south',
                height: 26,
                /*
                bbar: [ // Bottom Bar
                    { xtype: 'button', text: 'Button 1' }
                ]
                */ 
				/*
                dockedItems: [{
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: [
                        {
                            xtype: 'button',
                            text: 'Show Warning & Clear',
                            handler: function (){
                                var sb = Ext.getCmp('basic-statusbar');
                                sb.setStatus({
                                    text: 'Oops!',
                                    iconCls: 'x-status-error',
                                    clear: true // auto-clear after a set interval
                                });
                            }
                        },
                        {
                            xtype: 'button',
                            text: 'Show Busy',
                            handler: function (){
                                var sb = Ext.getCmp('basic-statusbar');
                                // Set the status bar to show that something is processing:
                                sb.showBusy();
                            }
                        },
                        {
                            xtype: 'button',
                            text: 'Clear status',
                            handler: function (){
                                var sb = Ext.getCmp('basic-statusbar');
                                // once completed
                                sb.clearStatus();
                            }
                        },
                        '-',
                        'Plain Text'
                    ]
                }]
                 */
            }, {
                region: 'center',
                border:true,
                layout:"fit",
                id: 'center',
                items: [{
                    contentEl: 'main',
                    title: '',
                    autoScroll: true
                }]
            }]
        });
});  
