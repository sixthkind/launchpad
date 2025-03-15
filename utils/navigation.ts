export function goBack(router: any) {
  if(router.canGoBack()) {
    router.back();
  } else {
    router.replace('/');
  }
}