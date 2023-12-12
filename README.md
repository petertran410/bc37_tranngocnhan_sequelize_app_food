Các phần xử lí trong route
  - Xử lí like nhà hàng
  // Like nhà hàng
    + POST localhost:3000/api/v1/likeRes/:resId/like  
                     
  // Lấy danh sách like theo user
    + GET localhost:3000/api/v1/user/:userId          
  // Lấy danh sách like theo nhà hàng    
    + GET localhost:3000/api/v1/restauranr/:resId         
    
  - Xử lí đánh giá nhà hàng
  // Thêm đánh giá      
    + POST localhost:3000/api/v1/rateRes/:resId/rate         
      
  // Lấy danh sách đánh giá theo user     
    + GET localhost:3000/api/v1/rateRes/user/:userId  
  // Lấy danh sách đánh giá theo nhà hàng      
    + GET localhost:3000/api/v1/rateRes/restaurant/:resId   
  
  - User đặt món (thêm order)
  // Thêm order 
    + POST localhost:3000/api/v1/orders/:foodId                          
      
       