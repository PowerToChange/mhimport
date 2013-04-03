/*
** 
* @class AD.Comm.Notification
* @parent notificationCenter
* 
* ##NotificationCenter
* 
* We repackage the OpenAjax.hub as our notification center.
*
*
* ##Usage:
*
*  suppose we have a nifty widget on a screen that displays a list of 
*  favorite TV shows.  Each time a new TV Show is created, it wants to 
*  refresh it's list of shows.
*
*  Please see the code examples in AD.Comm.Notification.publish and AD.Comm.Notification.subscribe
*  for instructions on how to do this.
*
*/

if (typeof AD.Comm == "undefined") {
    AD.Comm = {};
}

//--------------------------------------------------------------------------
AD.Comm.Notification = {};

/* 
 * @class AD.Comm.Notification.publish
 * @parent notificationCenter
 * @parent AD.Comm.Notification
 * 
 *  This widget would want to subscribe to the 'TVShow.Added' notification 
 *  like so:
 *  
 *  @codestart
 *      AD.Comm.Notification.subscribe('TVShow.Added', function(message, data) {
 *          //add entry contained in data to list
 *          listWidget.addEntry(data);
 *      });
 *  @codeend
 */
AD.Comm.Notification.publish = function(key, data){
    OpenAjax.hub.publish(key,data);
}

/* 
 * @class AD.Comm.Notification.subscribe
 * @parent notificationCenter
 * @parent AD.Comm.Notification
 *
 *  Then the widget that allowed you to create a new show would then publish
 *  a notification after the show has been created:
 *  
 *  @codestart
 *      AD.Comm.Notification.publish('TVShow.Added', { name:'Hawaii-5-O' });
 *  @codeend
 */
AD.Comm.Notification.subscribe = function(key,callback){
    OpenAjax.hub.subscribe(key,callback);
}



