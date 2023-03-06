package com.aiit.videomanagesystem.util;

import java.io.*;

import java.util.ArrayList;
import java.util.List;

public class VideoUtil {

    private static final String FFMPEG_PATH = "D:\\JAVA\\VideoUtil\\ffmpeg.exe";
    //mencoder存放的路径
    public static final String MENCODER_PATH = "D:\\JAVA\\VideoUtil\\mencoder.exe";
    //通过mencoder转换成的avi存放路径
    private static final String AVI_FILE_PATH = "D:\\VideoManagementSystem\\videotemp";
    //img存放路径
    private  static  final String IMG_FILE_PATH= "D:\\VideoManagementSystem\\videoImg";


    public static String processImg(String videoPath) {
        File file = new File(videoPath);
        if (!file.exists()) {
            System.err.println("路径[" + videoPath + "]对应的视频文件不存在!");
            return null;
        }
        List<String> commands = new java.util.ArrayList<String>();
        commands.add(FFMPEG_PATH);
        commands.add("-i");
        commands.add(videoPath);
        commands.add("-y");
        commands.add("-f");
        commands.add("image2");
        commands.add("-ss");
        commands.add("8");// 这个参数是设置截取视频多少秒时的画面
        // commands.add("-t");
        // commands.add("0.001");
        commands.add("-s");
        commands.add("1280x720");
        commands.add(IMG_FILE_PATH+"\\"+getVideoName(videoPath)+ ".jpg");
        StringBuffer test = new StringBuffer();
        for (int i = 0; i < commands.size(); i++) {
            test.append(commands.get(i) + " ");
        }

        System.out.println(test);
        try {
            ProcessBuilder builder = new ProcessBuilder();
            builder.command(commands);
            builder.start();
            System.out.println("截取成功");
            return IMG_FILE_PATH+"\\"+getVideoName(videoPath)+ ".jpg";
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String getVideoName(String VideoPath){
        File tempFile =new File(VideoPath.trim());
        String [] str=tempFile.getName().split("\\.");
        return str[0];
    }



    public static boolean ChangeFormat(String inputFile,String fileName) {
        //判断视频是否 存在
        if (!checkFile(inputFile)) {
            System.out.println(inputFile + " 文件不存在");
            return false;
        }

        //输出视频格式
        String outputFile="D:\\VideoManagementSystem\\video\\"+fileName;
        if (process(inputFile, outputFile)) {
            System.out.println("ok");
            return true;
        }
        return false;
    }

    // 检查文件是否存在
    private static boolean checkFile(String path) {
        File file = new File(path);
        if (!file.isFile()) {
            return false;

        }
        return true;
    }

    /**
     * @param inputFile
     * @param outputFile
     *  判断文件类型 是否为FFmpeg支持
     * @return 转换视频文件
     */
    private static boolean process(String inputFile, String outputFile) {
        int type = checkContentType(inputFile);
        boolean status = false;
        if (type == 0) {
            status = processFLV(inputFile, outputFile);// 直接将文件转为flv文件
        } else if (type == 1) {
            String avifilepath = processAVI(type, inputFile);
            if (avifilepath == null)
                return false;// avi文件没有得到
            status = processFLV(avifilepath, outputFile);// 将avi转为flv
        } else if (type == 9) {
            System.out.println("无法转化");
            return false;
        }
        return status;
    }

    private static int checkContentType(String inputFile) {
        String type = inputFile.substring(inputFile.lastIndexOf(".") + 1,
                inputFile.length()).toLowerCase();
        // ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）
        if (type.equals("avi")) {
            return 0;
        } else if (type.equals("mpg")) {
            return 0;
        } else if (type.equals("wmv")) {
            return 0;
        } else if (type.equals("3gp")) {
            return 0;
        } else if (type.equals("mov")) {
            return 0;
        } else if (type.equals("mp4")) {
            return 0;
        } else if (type.equals("asf")) {
            return 0;
        } else if (type.equals("asx")) {
            return 0;
        } else if (type.equals("flv")) {
            return 0;
        } else if (type.equals("mkv")) {
            return 0;
        }
        // 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等),
        // 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.
        else if (type.equals("wmv9")) {
            return 1;
        } else if (type.equals("rm")) {
            return 1;
        } else if (type.equals("rmvb")) {
            return 1;
        }
        return 9;
    }

    // ffmpeg能解析的格式：（asx，asf，mpg，wmv，3gp，mp4，mov，avi，flv等）直接转换为目标视频
    private static boolean processFLV(String inputFile, String outputFile) {
        if (!checkFile(inputFile)) {
            System.out.println(inputFile + " is not file");
            return false;
        }
        List<String> commend = new ArrayList<String>();

        commend.add(FFMPEG_PATH);
        commend.add("-i");
        commend.add(inputFile);
        commend.add(outputFile);
        StringBuffer test = new StringBuffer();
        for (int i = 0; i < commend.size(); i++) {
            test.append(commend.get(i) + " ");
        }

        System.out.println(test);

        try {
            ProcessBuilder builder = new ProcessBuilder();
            builder.command(commend);
            builder.start();
            if(checkFile(outputFile)){
                return true;
            }else return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 对ffmpeg无法解析的文件格式(wmv9，rm，rmvb等),
    // 可以先用别的工具（mencoder）转换为avi(ffmpeg能解析的)格式.
    private static String processAVI(int type, String inputFile) {
        File file = new File(AVI_FILE_PATH);
        if (file.exists())
            file.delete();
        List<String> commend = new ArrayList<String>();
        commend.add(MENCODER_PATH);
        commend.add(inputFile);
        commend.add("-oac");
        commend.add("mp3lame");
        commend.add("-lameopts");
        commend.add("preset=64");
        commend.add("-ovc");
        commend.add("xvid");
        commend.add("-xvidencopts");
        commend.add("bitrate=600");
        commend.add("-of");
        commend.add("avi");
        commend.add("-o");
        commend.add(AVI_FILE_PATH);
        StringBuffer test = new StringBuffer();
        for (int i = 0; i < commend.size(); i++) {
            test.append(commend.get(i) + " ");
        }

        System.out.println(test);
        try {
            ProcessBuilder builder = new ProcessBuilder();
            builder.command(commend);
            Process p = builder.start();

            final InputStream is1 = p.getInputStream();
            final InputStream is2 = p.getErrorStream();
            new Thread() {
                public void run() {
                    BufferedReader br = new BufferedReader(
                            new InputStreamReader(is1));
                    try {
                        String lineB = null;
                        while ((lineB = br.readLine()) != null) {
                            if (lineB != null)
                                System.out.println(lineB);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }.start();
            new Thread() {
                public void run() {
                    BufferedReader br2 = new BufferedReader(
                            new InputStreamReader(is2));
                    try {
                        String lineC = null;
                        while ((lineC = br2.readLine()) != null) {
                            if (lineC != null)
                                System.out.println(lineC);
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }.start();

            // 等Mencoder进程转换结束，再调用ffmepg进程
            p.waitFor();
            System.out.println("who cares");
            return AVI_FILE_PATH;
        } catch (Exception e) {
            System.err.println(e);
            return null;
        }
    }
}
