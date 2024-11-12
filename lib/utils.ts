import clsx, { ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";
// for util
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
