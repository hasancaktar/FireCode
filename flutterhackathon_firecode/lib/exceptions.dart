  class Exceptions{
  static String show(String exceptionCode){
    switch (exceptionCode) {
      case 'email-already-in-use':
        return 'Bu mail adresi zaten kullanılmaktadır';
      case 'wrong-password':
        return 'Yanlış şifre girildi';
      case 'user-not-found':
        return 'Kullanıcı bulunamadı';
      case 'NoResultFoundException':
        return 'Sonuç Bulunamadı';
      default:
        return 'Bir hata oluştu';
    }
  }
}