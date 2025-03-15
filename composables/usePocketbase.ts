import PocketBase from 'pocketbase';

export const usePocketbase = () => {
  const config: any = useRuntimeConfig();
  const pb = new PocketBase(config.public.pocketbaseURL);
  pb.autoCancellation(false);
  return pb;
} 