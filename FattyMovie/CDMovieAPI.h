//
//  CDMovieAPI.h
//  FattyMovie
//
//  Created by luo on 16/3/5.
//  Copyright © 2016年 luo. All rights reserved.
//

#ifndef CDMovieAPI_h
#define CDMovieAPI_h


/**排行接口*/
#define API_RANK @"http://www.biewang.com/rest/get_rank_film_list_for_app/"
/**热映大片接口*/
#define API_HOT @"http://www.biewang.com/rest/hot_film_list_for_app/"
/**电视剧接口*/
#define API_TELEPLAY @"http://www.biewang.com/rest/get_film_dytt_list_for_app/"
/**电影详情接口*/
#define API_MDETAIL @"http://biewang.com/rest/get_film_detail/"
/**每日更新接口*/
#define API_UPDATE @"http://www.biewang.com/rest/get_new_film_list_for_app/"
/**电视剧详情接口*/
#define API_TELEDETAIL @"http://biewang.com/rest/get_film_dytt_detail/"
/**搜索接口*/
#define API_SEARCH @"http://www.biewang.com/rest/get_film_dytt_search_list_for_app/"


/**豆瓣详情接口*/
#define API_DBDETAIL @"http://movie.douban.com/subject/"

/**豆瓣手机版详情*/
#define API_MDBDETAIL @"https://m.douban.com/movie/subject/"


#endif /* CDMovieAPI_h */
