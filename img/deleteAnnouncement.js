function deleteAnn(id){
    $ajax({
        url: '/announcements/' + id,
        type: 'DELETE',
        success: function(result){
            window.location.reload(true);
        }
    })
};