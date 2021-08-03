const BASE_Url = "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/";

//Login
const LOGIN = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/authentications/login';

//Patient
const GET_PATIENT_BY_ID_FROM_API = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/patients/patient/';
const GET_PATIENT_BY_PHONE_FROM_API = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/patients/patient/account/';
const GET_DATA_SHARING_OF_PATIENT = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/sharings/shared-information';

//Clinic
const GET_CLINIC_FROM_API = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/clinics/clinics';
const GET_CLINICS_BY_NAME_FROM_API = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/clinics/clinic/sub/';

//Examination
const GET_EXAMINATION_BY_PATIENTID_FROM_API = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/examinations/examination/test-request/';
const GET_EXAMINATION_BY_DATE_FROM_API = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/examinations/examination/date-range/patient';

//Examination_Detail
const GET_EXAMINATION_DETAIL_BY_EXAMINATIONID_FROM_API = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/examination-details/examination-detail/examination/';

//Rating
const POST_RATING = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/ratings/rating';

//User Family Group
const GET_LIST_GROUP = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/user-family-groups/user-family-group/family-group/patient/';
const CREATE_GROUP = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/family-groups/family-group';
const GET_INVITED_GROUP = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/family-groups/family-groups/inviting/';
const ADD_MEMBER = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/user-family-groups/user-family-group/';
const ACCEPT_INVITED = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/user-family-groups/user-family-group/';
const RENAME_GROUP = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/family-groups/family-group/';
const CHANGE_AVATAR_GROUP = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/commons/profile/pic/';

// Group Family Details
const GET_GROUP_FAMILY_DETAIL = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/user-family-groups/user-family-group/family-group/';
const DELETE_MEMBER = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/user-family-groups/user-family-group/';

//Sharing
const POST_SHARING_INFORMATION_TO_GROUP = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/sharings/sharing/group';
const EDIT_SHARING_INFORMATION_TO_GROUP = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/sharings/sharing/group';
const EDIT_SHARING_INFORMATION_TO_PATIENT = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/sharings/sharing/patient';
const POST_SHARING_INFORMATION_TO_PATIENT = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/sharings/sharing/patient';
const GET_SHARED_LIST = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/sharings/sharing/shared/';
const GET_SHARING_LIST = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/sharings/sharing/sharing/';

//Account
const UPDATE_TOKEN = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/accounts/account';
const SENT_NOTIFICATION = 'http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/commons/notification';