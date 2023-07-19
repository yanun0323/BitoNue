import SwiftUI

#if DEBUG
struct Mock {
    static var listWfhReply = try! JSONDecoder().decode(ListWfhReply.self, from: list.data(using: .utf8)!)
    
    private static var list = """
        {
        "code": 200,
        "data": {
        "list": [
            {"s_sn": "794449",
                "u_sn": "326806",
                "qry_no": "O2210260036",
                "inout_date": "2022-10-31",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-10-26 11:50:27",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": true,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "794451",
                "u_sn": "326806",
                "qry_no": "O2210260037",
                "inout_date": "2022-11-01",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-10-26 11:50:48",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": true,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "808507",
                "u_sn": "326806",
                "qry_no": "O2211080014",
                "inout_date": "2022-11-14",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-11-08 13:29:24",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": true,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "828915",
                "u_sn": "326806",
                "qry_no": "O2211250006",
                "inout_date": "2022-12-01",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-11-25 18:11:44",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "828917",
                "u_sn": "326806",
                "qry_no": "O2211250007",
                "inout_date": "2022-12-05",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-11-25 18:12:15",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "839956",
                "u_sn": "326806",
                "qry_no": "O2212050042",
                "inout_date": "2022-12-06",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公(確診)",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-12-05 19:06:53",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "839958",
                "u_sn": "326806",
                "qry_no": "O2212050044",
                "inout_date": "2022-12-07",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公(確診)",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-12-05 19:07:21",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "839962",
                "u_sn": "326806",
                "qry_no": "O2212050046",
                "inout_date": "2022-12-08",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公(確診)",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-12-05 19:08:11",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "839964",
                "u_sn": "326806",
                "qry_no": "O2212050048",
                "inout_date": "2022-12-09",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公(確診)",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-12-05 19:08:44",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "853870",
                "u_sn": "326806",
                "qry_no": "O2212180001",
                "inout_date": "2022-12-22",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "居家辦公",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-12-18 21:27:29",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=%E5%B1%85%E5%AE%B6%E8%BE%A6%E5%85%AC&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "863396",
                "u_sn": "326806",
                "qry_no": "O2212260017",
                "inout_date": "2022-12-30",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2022-12-26 18:17:37",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "881220",
                "u_sn": "326806",
                "qry_no": "O2301100014",
                "inout_date": "2023-01-17",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-01-10 15:50:34",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "881223",
                "u_sn": "326806",
                "qry_no": "O2301100015",
                "inout_date": "2023-01-18",
                "out_time": "09:00",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-01-10 15:50:59",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "881225",
                "u_sn": "326806",
                "qry_no": "O2301100016",
                "inout_date": "2023-01-19",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-01-10 15:51:29",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "902992",
                "u_sn": "326806",
                "qry_no": "O2302060012",
                "inout_date": "2023-02-10",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "居家辦公",
                "remark": "居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-02-06 11:16:32",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=%E5%B1%85%E5%AE%B6%E8%BE%A6%E5%85%AC&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "903001",
                "u_sn": "326806",
                "qry_no": "O2302060013",
                "inout_date": "2023-02-17",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "居家辦公",
                "remark": "居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-02-06 11:20:34",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=%E5%B1%85%E5%AE%B6%E8%BE%A6%E5%85%AC&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "920878",
                "u_sn": "326806",
                "qry_no": "O2302200025",
                "inout_date": "2023-02-24",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "居家辦公",
                "remark": "居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-02-20 23:49:11",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=%E5%B1%85%E5%AE%B6%E8%BE%A6%E5%85%AC&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "935618",
                "u_sn": "326806",
                "qry_no": "O2303060033",
                "inout_date": "2023-03-10",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-03-06 22:41:30",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "952595",
                "u_sn": "326806",
                "qry_no": "O2303200023",
                "inout_date": "2023-03-24",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-03-20 18:25:34",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "952596",
                "u_sn": "326806",
                "qry_no": "O2303200024",
                "inout_date": "2023-03-25",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-03-20 18:26:51",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "952599",
                "u_sn": "326806",
                "qry_no": "O2303200026",
                "inout_date": "2023-03-31",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-03-20 18:28:01",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "971884",
                "u_sn": "326806",
                "qry_no": "O2304060032",
                "inout_date": "2023-04-14",
                "out_time": "09:00",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "3",
                "sign_log": {
                    "reply_amount": "1"
                },
                "c_date": "2023-04-06 18:25:36",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "971890",
                "u_sn": "326806",
                "qry_no": "O2304060034",
                "inout_date": "2023-04-21",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-04-06 18:27:50",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "971891",
                "u_sn": "326806",
                "qry_no": "O2304060035",
                "inout_date": "2023-04-28",
                "out_time": "09:00",
                "in_time": "18:30",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "3",
                "sign_log": {
                    "reply_amount": "1"
                },
                "c_date": "2023-04-06 18:28:10",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "976400",
                "u_sn": "326806",
                "qry_no": "O2304110003",
                "inout_date": "2023-04-28",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-04-11 09:51:20",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1002140",
                "u_sn": "326806",
                "qry_no": "O2305020018",
                "inout_date": "2023-05-05",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "居家辦公",
                "remark": "居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-05-02 11:30:48",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=%E5%B1%85%E5%AE%B6%E8%BE%A6%E5%85%AC&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1018554",
                "u_sn": "326806",
                "qry_no": "O2305150018",
                "inout_date": "2023-05-19",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "居家辦公",
                "remark": "居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-05-15 16:08:41",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=%E5%B1%85%E5%AE%B6%E8%BE%A6%E5%85%AC&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1018557",
                "u_sn": "326806",
                "qry_no": "O2305150019",
                "inout_date": "2023-05-26",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "居家辦公",
                "remark": "居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-05-15 16:09:33",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=%E5%B1%85%E5%AE%B6%E8%BE%A6%E5%85%AC&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1044101",
                "u_sn": "326806",
                "qry_no": "O2306020005",
                "inout_date": "2023-06-09",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-02 21:45:47",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1044102",
                "u_sn": "326806",
                "qry_no": "O2306020006",
                "inout_date": "2023-06-16",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-02 21:46:10",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1057217",
                "u_sn": "326806",
                "qry_no": "O2306140005",
                "inout_date": "2023-06-17",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-14 10:41:31",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1072682",
                "u_sn": "326806",
                "qry_no": "O2306280012",
                "inout_date": "2023-06-21",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "確診居家辦公",
                "address": "",
                "remark": "確診居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-28 14:58:20",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1072675",
                "u_sn": "326806",
                "qry_no": "O2306280007",
                "inout_date": "2023-06-27",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "確診居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-28 14:55:27",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1072679",
                "u_sn": "326806",
                "qry_no": "O2306280009",
                "inout_date": "2023-06-27",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "確診居家辦公",
                "address": "",
                "remark": "確診居家辦公",
                "sign_status": "3",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-28 14:56:34",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1072676",
                "u_sn": "326806",
                "qry_no": "O2306280008",
                "inout_date": "2023-06-28",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "確診居家辦公",
                "address": "",
                "remark": "確診居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-28 14:55:53",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1072680",
                "u_sn": "326806",
                "qry_no": "O2306280010",
                "inout_date": "2023-06-29",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "確診居家辦公",
                "address": "",
                "remark": "確診居家辦公",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-28 14:57:35",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1044104",
                "u_sn": "326806",
                "qry_no": "O2306020008",
                "inout_date": "2023-06-30",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-06-02 21:47:06",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1088345",
                "u_sn": "326806",
                "qry_no": "O2307110001",
                "inout_date": "2023-07-14",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "3",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-07-11 10:53:26",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1088353",
                "u_sn": "326806",
                "qry_no": "O2307110002",
                "inout_date": "2023-07-21",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "2",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-07-11 10:56:56",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            },
            {
                "s_sn": "1088354",
                "u_sn": "326806",
                "qry_no": "O2307110003",
                "inout_date": "2023-07-28",
                "out_time": "09:30",
                "in_time": "18:00",
                "out_status": "1",
                "in_status": "1",
                "destination": "居家辦公",
                "address": "",
                "remark": "",
                "sign_status": "1",
                "sign_log": {
                    "reply_amount": "0"
                },
                "c_date": "2023-07-11 10:59:08",
                "u_no": "0099",
                "username": "楊永煜 Yanun Yang",
                "remark2": "上班不進公司(系統依'外出時間'自動新增上班打卡時間)下班不進公司(系統依'返回時間'自動新增下班打卡時間)",
                "iosignin": false,
                "map_link": "https://www.google.com/maps/dir/?api=1&destination=&travelmode=driving",
                "userDetail": {
                    "326806": {
                        "d_sn": "61112",
                        "dept_name": "研發工程部",
                        "title_name": "Junior Backend Engineer"
                    }
                }
            }
        ],
        "badges": {
            "all": 42,
            "waiting": 2,
            "approved": 37,
            "rejected": 3
        }
        }
        }
        """
}

#endif
